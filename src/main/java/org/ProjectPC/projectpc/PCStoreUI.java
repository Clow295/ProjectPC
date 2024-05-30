package org.ProjectPC.projectpc;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;
import java.net.URL;
import java.sql.*;
import entity.*;
import java.util.Vector;

public class PCStoreUI extends JFrame {
	private JPanel mainPanel;
    private JMenuBar menuBar;
	private JTable table;
	private JTextField searchName;

	public PCStoreUI() {
		setTitle("PC Store Management");
		setSize(1200, 800);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setLocationRelativeTo(null);

		Font newFont = new Font("Sans Serif", Font.PLAIN, 14);
        setUIFont(newFont);
		
		// Menu bar
		menuBar = new JMenuBar();
        JMenu menu = new JMenu("Menu");
        
        JMenuItem searchMenuItem = new JMenuItem("Tìm kiếm PC");
        JMenuItem consultMenuItem = new JMenuItem("Tư vấn PC");

        searchMenuItem.addActionListener(e -> {
            CardLayout cardLayout = (CardLayout) mainPanel.getLayout();
            cardLayout.show(mainPanel, "productList");
        });

        consultMenuItem.addActionListener(e -> {
            CardLayout cardLayout = (CardLayout) mainPanel.getLayout();
            cardLayout.show(mainPanel, "consultUI");
        });

        menu.add(searchMenuItem);
        menu.add(consultMenuItem);
        menuBar.add(menu);
        setJMenuBar(menuBar);
        
		mainPanel = new JPanel(new CardLayout());

		// Sort
		JPanel productListPanel = new JPanel(new BorderLayout());

		searchName = new JTextField(20);
		JButton filterButton = new JButton("Tìm kiếm");

		JPanel filterPanel = new JPanel();
		filterPanel.setBackground(Color.cyan);
		filterPanel.add(new JLabel("Tên sản phẩm:"));
		filterPanel.add(searchName);
		filterPanel.add(filterButton);

		table = new JTable();
		table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		table.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				if (e.getClickCount() == 2) { // Double-click detected
					int selectedRow = table.getSelectedRow();
					if (selectedRow >= 0) {
						showProductDetails(selectedRow);
					}
				}
			}
		});
		
		productListPanel.add(filterPanel, BorderLayout.NORTH);
		productListPanel.add(new JScrollPane(table), BorderLayout.CENTER);

		mainPanel.add(productListPanel, "productList");

		// Consultation Panel
		ConsultUI consultUI = new ConsultUI();
        mainPanel.add(consultUI, "consultUI");

        add(mainPanel);

		filterButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				filterProducts();
			}
		});
		loadProducts();
	}

	public static void setUIFont(Font font) {
        java.util.Enumeration<Object> keys = UIManager.getDefaults().keys();
        while (keys.hasMoreElements()) {
            Object key = keys.nextElement();
            Object value = UIManager.get(key);
            if (value instanceof javax.swing.plaf.FontUIResource) {
                UIManager.put(key, font);
            }
        }
    }
	
	private void loadProducts() {
		try (Connection conn = DatabaseConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT p.id, p.name, p.image, p.price, p.mota, b.bname, u.uname "
						+ "FROM product p " + "JOIN brands b ON p.bid = b.bid " + "JOIN usages u ON p.uid = u.uid")) {

			table.setModel(buildTableModel(rs));

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void filterProducts() {
		String productName = searchName.getText().trim();

		StringBuilder query = new StringBuilder("SELECT p.id, p.name, p.image, p.price, p.mota, b.bname, u.uname "
				+ "FROM product p " + "JOIN brands b ON p.bid = b.bid " + "JOIN usages u ON p.uid = u.uid WHERE 1=1");

		if (!productName.isEmpty()) {
            query.append(" AND p.name LIKE '%").append(productName).append("%'");

		}

		try (Connection conn = DatabaseConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query.toString())) {

			ResultSet rs = pstmt.executeQuery();
			table.setModel(buildTableModel(rs));


		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private DefaultTableModel buildTableModel(ResultSet rs) throws SQLException {
		ResultSetMetaData metaData = rs.getMetaData();

		String[] columnNames = { "ID", "Tên sản phẩm", "Hình ảnh", "Giá", "Mô tả", "Thương hiệu", "Nhu cầu" };

		Vector<String> columnVector = new Vector<>(java.util.Arrays.asList(columnNames));
		Vector<Vector<Object>> data = new Vector<>();

		while (rs.next()) {
			Vector<Object> vector = new Vector<>();
			for (int columnIndex = 1; columnIndex <= columnNames.length; columnIndex++) {
				if (columnIndex == 3) { // Assuming 3rd column is the image URL
					vector.add(getImageIcon(rs.getString("image")));
				} else {
					vector.add(rs.getObject(columnIndex));
				}
			}
			data.add(vector);
		}

		DefaultTableModel model = new DefaultTableModel(data, columnVector) {
			@Override
			public Class<?> getColumnClass(int column) {
				if (column == 2) { // Assuming 3rd column is the image URL
					return ImageIcon.class;
				} else {
					return Object.class;
				}
			}

			@Override
			public boolean isCellEditable(int row, int column) {
				return false; // Make cells non-editable
			}
		};
		table.setRowHeight(200);
		return model;
	}

	public static ImageIcon getImageIcon(String url) {
		try {
			URL imageUrl = new URL(url);
			ImageIcon imageIcon = new ImageIcon(imageUrl);
			// Resize the image if needed
			Image image = imageIcon.getImage();
			Image resizedImage = image.getScaledInstance(300, 300, Image.SCALE_SMOOTH);
			return new ImageIcon(resizedImage);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private void showProductDetails(int rowIndex) {
		DefaultTableModel model = (DefaultTableModel) table.getModel();
		Vector<?> rowData = model.getDataVector().elementAt(rowIndex);

		String id = rowData.elementAt(0).toString();
		String name = rowData.elementAt(1).toString();
		ImageIcon image = (ImageIcon) rowData.elementAt(2);
		String price = rowData.elementAt(3).toString();
		String mota = rowData.elementAt(4).toString();
		String brand = rowData.elementAt(5).toString();
		String usage = rowData.elementAt(6).toString();

		ProductDetail detailPanel = new ProductDetail(id, name, image, price, mota, brand, usage);
		mainPanel.add(detailPanel, "ProductDetail");

		CardLayout cardLayout = (CardLayout) mainPanel.getLayout();
		cardLayout.show(mainPanel, "ProductDetail");
	}

	public static void main(String[] args) {
		SwingUtilities.invokeLater(() -> {
			PCStoreUI ui = new PCStoreUI();
			ui.setVisible(true);
			ui.loadProducts();
		});
	}
}


