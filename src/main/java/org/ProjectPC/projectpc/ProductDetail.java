package org.ProjectPC.projectpc;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Vector;

import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;

//public class ProductDetail extends JPanel {
//
//    private JTable detailTable;
//
//    public ProductDetail(String id, String name, ImageIcon image, String price, String mota, String brand, String usage) {
//        setLayout(new BorderLayout(0, 0));
//        
//        JPanel productInfoPanel = new JPanel();
//        productInfoPanel.setLayout(new BoxLayout(productInfoPanel, BoxLayout.Y_AXIS));
//        
//        productInfoPanel.add(new JLabel("Tên sản phẩm: " + name));
//
//        JLabel imageLabel = new JLabel(image);
//        imageLabel.setPreferredSize(new Dimension(150, 150));
//        productInfoPanel.add(imageLabel);
//
//        productInfoPanel.add(new JLabel("Giá: " + price));
//        productInfoPanel.add(new JLabel("Mô tả: " + mota));
//        productInfoPanel.add(new JLabel("Thương hiệu: " + brand));
//        productInfoPanel.add(new JLabel("Nhu cầu: " + usage));
//
//        add(productInfoPanel, BorderLayout.NORTH);
//
//        detailTable = new JTable();
//        fetchProductDetails(id);
//
//        add(new JScrollPane(detailTable), BorderLayout.CENTER);
//
//        JButton backButton = new JButton("Quay lại");
//        backButton.addActionListener(e -> {
//            CardLayout cardLayout = (CardLayout) getParent().getLayout();
//            cardLayout.show(getParent(), "productList");
//        });
//
//        JPanel buttonPanel = new JPanel();
//        buttonPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
//        buttonPanel.add(backButton);
//        add(buttonPanel, BorderLayout.SOUTH);
//    }
//
//    private void fetchProductDetails(String productId) {
//        try (Connection conn = DatabaseConnection.getConnection();
//             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM detail WHERE id = ?")) {
//            pstmt.setString(1, productId);
//
//            ResultSet rs = pstmt.executeQuery();
//            DefaultTableModel model = buildTableModel(rs);
//            DefaultTableModel rotatedModel = rotateAndAddHeader(model);
//            detailTable.setModel(rotatedModel);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
//
//    private DefaultTableModel buildTableModel(ResultSet rs) throws SQLException {
//        ResultSetMetaData metaData = rs.getMetaData();
//
//        int columnCount = metaData.getColumnCount();
//        Vector<String> columnNames = new Vector<>();
//        for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
//            columnNames.add(metaData.getColumnName(columnIndex));
//        }
//
//        Vector<Vector<Object>> data = new Vector<>();
//        while (rs.next()) {
//            Vector<Object> vector = new Vector<>();
//            for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
//                vector.add(rs.getObject(columnIndex));
//            }
//            data.add(vector);
//        }
//
//        return new DefaultTableModel(data, columnNames) {
//            @Override
//            public boolean isCellEditable(int row, int column) {
//                return false; // Make cells non-editable
//            }
//        };
//    }
//
//    private DefaultTableModel rotateAndAddHeader(DefaultTableModel model) {
//        String[] headers = {"ID", "CPU", "Mainboard", "RAM", "Ổ cứng", "GPU", "Nguồn", "Vỏ case", "Tản nhiệt"};
//        int rowCount = model.getRowCount();
//        int columnCount = model.getColumnCount();
//
//        // Create new data structure with headers
//        Vector<Vector<Object>> data = new Vector<>();
//        for (int rowIndex = 0; rowIndex < headers.length; rowIndex++) {
//            Vector<Object> vector = new Vector<>();
//            vector.add(headers[rowIndex]);
//            for (int colIndex = 0; colIndex < rowCount; colIndex++) {
//                if (rowIndex < columnCount) {
//                    vector.add(model.getValueAt(colIndex, rowIndex));
//                } else {
//                    vector.add(null); // Handle cases where headers are more than columns in data
//                }
//            }
//            data.add(vector);
//        }
//
//     // Remove the first two rows
//        if (data.size() > 2) {
//            data.remove(0); // Remove first row
//        }
//        
//        Vector<String> columnNames = new Vector<>();
//        columnNames.add("");
//        columnNames.add("");
//        for (int i = 2; i <= rowCount; i++) {
//            columnNames.add("" + i);
//        }
//        
//        detailTable.setRowHeight(50);
//        detailTable.setFont(new Font("Sans Serif", Font.PLAIN, 16));
//        return new DefaultTableModel(data, columnNames) {
//            @Override
//            public boolean isCellEditable(int row, int column) {
//                return false; // Make cells non-editable
//            }
//        };
//        
//    }
//}


public class ProductDetail extends JPanel {

    private JTable detailTable;
    private String productName;
    private String productDescription;
    private String productPrice;

    public ProductDetail(String id, String name, ImageIcon image, String price, String mota, String brand, String usage) {
        this.productName = name;
        this.productDescription = mota;
        this.productPrice = price;
        
        setLayout(new BorderLayout(0, 0));
        
        JPanel productInfoPanel = new JPanel();
        productInfoPanel.setLayout(new BoxLayout(productInfoPanel, BoxLayout.Y_AXIS));
        
        productInfoPanel.add(new JLabel("Tên sản phẩm: " + name));

        JLabel imageLabel = new JLabel(image);
        imageLabel.setPreferredSize(new Dimension(250, 250));
        productInfoPanel.add(imageLabel);

        productInfoPanel.add(new JLabel("Giá: " + price));
        productInfoPanel.add(new JLabel("Mô tả: " + mota));
        productInfoPanel.add(new JLabel("Thương hiệu: " + brand));
        productInfoPanel.add(new JLabel("Nhu cầu: " + usage));

        add(productInfoPanel, BorderLayout.NORTH);

        detailTable = new JTable();
        fetchProductDetails(id);

        add(new JScrollPane(detailTable), BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.RIGHT));
        
        JButton backButton = new JButton("Quay lại");
        backButton.addActionListener(e -> {
            CardLayout cardLayout = (CardLayout) getParent().getLayout();
            cardLayout.show(getParent(), "productList");
        });

        JButton checkoutButton = new JButton("Thanh toán");
        checkoutButton.addActionListener(e -> {
            CardLayout cardLayout = (CardLayout) getParent().getLayout();
            Cart cartPanel = new Cart(productName, productDescription, productPrice, detailTable.getModel());
            getParent().add(cartPanel, "checkout");
            cardLayout.show(getParent(), "checkout");
        });

        buttonPanel.add(checkoutButton);
        buttonPanel.add(backButton);
        add(buttonPanel, BorderLayout.SOUTH);
    }

    private void fetchProductDetails(String productId) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM detail WHERE id = ?")) {
            pstmt.setString(1, productId);

            ResultSet rs = pstmt.executeQuery();
            DefaultTableModel model = buildTableModel(rs);
            DefaultTableModel rotatedModel = rotateAndAddHeader(model);
            detailTable.setModel(rotatedModel);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private DefaultTableModel buildTableModel(ResultSet rs) throws SQLException {
        ResultSetMetaData metaData = rs.getMetaData();

        int columnCount = metaData.getColumnCount();
        Vector<String> columnNames = new Vector<>();
        for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
            columnNames.add(metaData.getColumnName(columnIndex));
        }

        Vector<Vector<Object>> data = new Vector<>();
        while (rs.next()) {
            Vector<Object> vector = new Vector<>();
            for (int columnIndex = 1; columnIndex <= columnCount; columnIndex++) {
                vector.add(rs.getObject(columnIndex));
            }
            data.add(vector);
        }

        return new DefaultTableModel(data, columnNames) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Make cells non-editable
            }
        };
    }

    private DefaultTableModel rotateAndAddHeader(DefaultTableModel model) {
        String[] headers = {"ID", "CPU", "Mainboard", "RAM", "Ổ cứng", "GPU", "Nguồn", "Vỏ case", "Tản nhiệt"};
        int rowCount = model.getRowCount();
        int columnCount = model.getColumnCount();

        // Create new data structure with headers
        Vector<Vector<Object>> data = new Vector<>();
        for (int rowIndex = 0; rowIndex < headers.length; rowIndex++) {
            Vector<Object> vector = new Vector<>();
            vector.add(headers[rowIndex]);
            for (int colIndex = 0; colIndex < rowCount; colIndex++) {
                if (rowIndex < columnCount) {
                    vector.add(model.getValueAt(colIndex, rowIndex));
                } else {
                    vector.add(null); // Handle cases where headers are more than columns in data
                }
            }
            data.add(vector);
        }

        // Remove the first row
        if (data.size() > 0) {
            data.remove(0); // Remove first row
        }

        Vector<String> columnNames = new Vector<>();
        columnNames.add("");
        columnNames.add("");
        for (int i = 2; i <= rowCount; i++) {
            columnNames.add("" + i);
        }

        detailTable.setRowHeight(50);
        detailTable.setFont(new Font("Sans Serif", Font.PLAIN, 16));
        return new DefaultTableModel(data, columnNames) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false; // Make cells non-editable
            }
        };
    }
}