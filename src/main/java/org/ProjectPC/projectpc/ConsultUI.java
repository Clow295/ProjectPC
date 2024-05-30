package org.ProjectPC.projectpc;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.SwingUtilities;
import javax.swing.table.DefaultTableModel;

import entity.*;

public class ConsultUI extends JPanel {
	private JComboBox<Brand> filterBrand;
	private JComboBox<Usage> filterUsage;
	private JTextField minPrice;
	private JTextField maxPrice;
	private JTable table;

	public ConsultUI() {
		setLayout(new BorderLayout());

		filterBrand = new JComboBox<>();
		filterUsage = new JComboBox<>();
		minPrice = new JTextField(10);
		maxPrice = new JTextField(10);
		JButton filterButton = new JButton("Tư vấn");

		JPanel filterPanel = new JPanel();
		filterPanel.setBackground(Color.cyan);
		filterPanel.add(new JLabel("Thương hiệu:"));
		filterPanel.add(filterBrand);
		filterPanel.add(new JLabel("Nhu cầu:"));
		filterPanel.add(filterUsage);
		filterPanel.add(new JLabel("Giá tối thiểu:"));
		filterPanel.add(minPrice);
		filterPanel.add(new JLabel("Giá tối đa:"));
		filterPanel.add(maxPrice);
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

		add(filterPanel, BorderLayout.NORTH);
		add(new JScrollPane(table), BorderLayout.CENTER);

		filterButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				consultProducts();
			}
		});

		loadBrands();
		loadUsages();
	}

	private void loadBrands() {
		try (Connection conn = DatabaseConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT bid, bname FROM brands")) {

			filterBrand.addItem(new Brand(0, "All"));
			while (rs.next()) {
				int id = rs.getInt("bid");
				String name = rs.getString("bname");
				filterBrand.addItem(new Brand(id, name));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void loadUsages() {
		try (Connection conn = DatabaseConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT uid, uname FROM usages")) {

			filterUsage.addItem(new Usage(0, "All"));
			while (rs.next()) {
				int id = rs.getInt("uid");
				String name = rs.getString("uname");
				filterUsage.addItem(new Usage(id, name));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void consultProducts() {
		Brand selectedBrand = (Brand) filterBrand.getSelectedItem();
		Usage selectedUsage = (Usage) filterUsage.getSelectedItem();
		String minPriceText = minPrice.getText();
		String maxPriceText = maxPrice.getText();

		StringBuilder query = new StringBuilder("SELECT p.id, p.name, p.image, p.price, p.mota, b.bname, u.uname "
				+ "FROM product p " + "JOIN brands b ON p.bid = b.bid " + "JOIN usages u ON p.uid = u.uid WHERE 1=1");

		if (selectedBrand != null && selectedBrand.getId() != 0) {
			query.append(" AND p.bid = ").append(selectedBrand.getId());
		}

		if (selectedUsage != null && selectedUsage.getId() != 0) {
			query.append(" AND p.uid = ").append(selectedUsage.getId());
		}

		if (!minPriceText.isEmpty()) {
			query.append(" AND p.price >= ").append(minPriceText);
		}

		if (!maxPriceText.isEmpty()) {
			query.append(" AND p.price <= ").append(maxPriceText);
		}

		query.append(" ORDER BY p.price DESC");

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
					vector.add(PCStoreUI.getImageIcon(rs.getString("image")));
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
		table.setRowHeight(150);
		return model;
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

		ProductDetail cartPanel = new ProductDetail(id, name, image, price, mota, brand, usage);
		JFrame frame = (JFrame) SwingUtilities.getWindowAncestor(this);
		JPanel mainPanel = (JPanel) frame.getContentPane().getComponent(0);
		mainPanel.add(cartPanel, "ProductDetail");

		CardLayout cardLayout = (CardLayout) mainPanel.getLayout();
		cardLayout.show(mainPanel, "ProductDetail");
	}
}
