package org.ProjectPC.projectpc;

import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.table.TableModel;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Cart extends JPanel {

    private JTextField nameField;
    private JTextField addressField;
    private JTable productTable;
    private TableModel productModel;
    private String productName;
    private String productDescription;
    private String productPrice;

    public Cart(String name, String description, String price, TableModel tableModel) {
        this.productName = name;
        this.productDescription = description;
        this.productPrice = price;
        this.productModel = tableModel;

        setLayout(new BorderLayout(0, 0));

        JPanel formPanel = new JPanel(new GridLayout(5, 2));

        formPanel.add(new JLabel("Tên:"));
        nameField = new JTextField();
        formPanel.add(nameField);

        formPanel.add(new JLabel("Địa chỉ:"));
        addressField = new JTextField();
        formPanel.add(addressField);

        formPanel.add(new JLabel("Giá tiền: " + productPrice));
                
        add(formPanel, BorderLayout.NORTH);

        productTable = new JTable(productModel);
        add(new JScrollPane(productTable), BorderLayout.CENTER);
        productTable.setRowHeight(50);
       
        JButton confirmButton = new JButton("Xác nhận");
        confirmButton.addActionListener(e -> {
            saveToExcel();
            showThankYouMessage();
        });

        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.RIGHT));
        buttonPanel.add(confirmButton);
        add(buttonPanel, BorderLayout.SOUTH);
    }

    private void saveToExcel() {
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Order Details");

            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("Tên");
            headerRow.createCell(1).setCellValue(nameField.getText());

            Row addressRow = sheet.createRow(1);
            addressRow.createCell(0).setCellValue("Địa chỉ");
            addressRow.createCell(1).setCellValue(addressField.getText());

            Row productNameRow = sheet.createRow(2);
            productNameRow.createCell(0).setCellValue("Tên sản phẩm");
            productNameRow.createCell(1).setCellValue(productName);

            Row productDescriptionRow = sheet.createRow(3);
            productDescriptionRow.createCell(0).setCellValue("Mô tả");
            productDescriptionRow.createCell(1).setCellValue(productDescription);

            Row productPriceRow = sheet.createRow(4);
            productPriceRow.createCell(0).setCellValue("Giá");
            productPriceRow.createCell(1).setCellValue(productPrice);

            int rowCount = 6;
            for (int row = 0; row < productModel.getRowCount(); row++) {
                Row excelRow = sheet.createRow(rowCount++);
                for (int col = 0; col < productModel.getColumnCount(); col++) {
                    excelRow.createCell(col).setCellValue(productModel.getValueAt(row, col).toString());
                }
            }

            String fileName = generateUniqueFileName(nameField.getText(), addressField.getText());
         // Create the folder if it doesn't exist
            File folder = new File("HoaDon");
            if (!folder.exists()) {
                folder.mkdirs(); 
            }

            // Save the file in the folder
            try (FileOutputStream fileOut = new FileOutputStream(new File(folder, fileName))) {
                workbook.write(fileOut);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    private String generateUniqueFileName(String name, String address) {
        // Normalize the name and address to create a valid file name
        String normalizedName = normalizeString(name);
        String normalizedAddress = normalizeString(address);

        // Get the current date and time
        String dateTime = new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new Date());

        // Combine them to create a unique file name
        return normalizedName + normalizedAddress + dateTime + ".xlsx";
    }

    private String normalizeString(String input) {
        // Remove non-alphanumeric characters and convert to lowercase
        return input.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
    }
    
    private void showThankYouMessage() {
        removeAll(); // Remove all existing components

        setLayout(new BorderLayout());

        JLabel thankYouLabel = new JLabel("Cảm ơn đã mua hàng", JLabel.CENTER);
        thankYouLabel.setFont(new Font("Sans Serif", Font.BOLD, 24));
        add(thankYouLabel, BorderLayout.CENTER);

        JButton backButton = new JButton("Quay lại");
        backButton.addActionListener(e -> {
            CardLayout cardLayout = (CardLayout) getParent().getLayout();
            cardLayout.show(getParent(), "productList");
        });

        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER));
        buttonPanel.add(backButton);
        add(buttonPanel, BorderLayout.SOUTH);

        revalidate();
        repaint();
    }
}
