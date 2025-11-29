package models;

/**
 * Model sederhana untuk entitas Produk.
 * POJO (Plain Old Java Object) sesuai konsep MVC.
 */
public class Product {
    private int id;
    private String name;
    private String category;
    private double price;
    private int stock;
    private String description;

    // Constructor kosong
    public Product() { }

    // Constructor lengkap
    public Product(int id, String name, String category, double price, int stock, String description) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.description = description;
    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public double getPrice() { return price; }
    public int getStock() { return stock; }
    public String getDescription() { return description; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setCategory(String category) { this.category = category; }
    public void setPrice(double price) { this.price = price; }
    public void setStock(int stock) { this.stock = stock; }
    public void setDescription(String description) { this.description = description; }
}