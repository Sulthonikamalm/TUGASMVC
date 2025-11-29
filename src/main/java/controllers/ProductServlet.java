package controllers;

import models.Product;
import models.ProductRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * ProductServlet bertindak sebagai Controller utama.
 * Validasi Server-Side (Tugas 1).
 */
@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private ProductRepository repo;

    @Override
    public void init() throws ServletException {
        // Inisialisasi repository saat Servlet pertama kali dimuat
        if (repo == null) {
            repo = new ProductRepository(); 
        }
    }

    // Menangani Request GET (Menampilkan data/form)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        // Jika action kosong atau 'list', tampilkan daftar produk
        if (action == null || action.equals("list")) {
            request.setAttribute("products", repo.findAll());
            request.getRequestDispatcher("/views/list_product.jsp").forward(request, response);

        // Fitur Search
        } else if (action.equals("search")) {
            String keyword = request.getParameter("keyword");
            request.setAttribute("products", repo.search(keyword));
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/views/list_product.jsp").forward(request, response);

        // Menampilkan Form Tambah
        } else if (action.equals("add")) {
            request.setAttribute("product", new Product()); // Kirim objek kosong untuk form
            request.getRequestDispatcher("/views/form_product.jsp").forward(request, response);

        // Menampilkan Form Edit
        } else if (action.equals("edit")) {
            int id = parseIntSafe(request.getParameter("id"), -1);
            Product p = repo.findById(id);
            if (p != null) {
                request.setAttribute("product", p);
                request.getRequestDispatcher("/views/form_product.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Produk tidak ditemukan");
            }
        }
    }

    // Menangani Request POST (Simpan/Update/Hapus data)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        // Logika untuk ADD dan EDIT
        if ("add".equals(action) || "edit".equals(action)) {
            Product p = buildProductFromRequest(request);
            
            // --- JAWABAN TUGAS 1: VALIDASI SERVER-SIDE ---
            String validationError = validateProductInput(p); 

            if (validationError != null) {
                // Jika validasi GAGAL:
                request.setAttribute("error", validationError);
                request.setAttribute("product", p); 
                request.getRequestDispatcher("/views/form_product.jsp").forward(request, response);
                return; 
            }
            // ---------------------------------------------
            
            if ("add".equals(action)) {
                repo.add(p);
                request.setAttribute("message", "Produk berhasil ditambahkan");
            } else { 
                int id = parseIntSafe(request.getParameter("id"), -1);
                p.setId(id); 
                repo.update(p);
                request.setAttribute("message", "Produk berhasil diubah");
            }
            // Setelah sukses, kembali ke list
            request.setAttribute("products", repo.findAll());
            request.getRequestDispatcher("/views/list_product.jsp").forward(request, response);

        // Logika untuk DELETE
        } else if ("delete".equals(action)) {
            int id = parseIntSafe(request.getParameter("id"), -1);
            repo.delete(id);
            request.setAttribute("message", "Produk berhasil dihapus");
            request.setAttribute("products", repo.findAll());
            request.getRequestDispatcher("/views/list_product.jsp").forward(request, response);
        }
    }
    
    // --- METHOD VALIDASI (JAWABAN TUGAS 1) ---
    private String validateProductInput(Product p) {
        if (p.getName() == null || p.getName().trim().isEmpty()) {
            return "Nama produk wajib diisi.";
        }
        if (p.getCategory() == null || p.getCategory().trim().isEmpty()) {
            return "Kategori wajib diisi.";
        }
        if (p.getPrice() < 0) {
            return "Harga tidak boleh bernilai negatif.";
        }
        if (p.getStock() < 0) {
            return "Stok tidak boleh bernilai negatif.";
        }
        return null;
    }

    // Helper untuk mengambil data dari form
    private Product buildProductFromRequest(HttpServletRequest request) {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = parseDoubleSafe(request.getParameter("price"), -1.0);
        int stock = parseIntSafe(request.getParameter("stock"), -1);
        String description = request.getParameter("description");
        
        return new Product(0, name, category, price, stock, description);
    }

    private int parseIntSafe(String s, int def) {
        try { return Integer.parseInt(s.trim()); } catch (Exception e) { return def; }
    }
    
    private double parseDoubleSafe(String s, double def) {
        try { return Double.parseDouble(s.trim()); } catch (Exception e) { return def; }
    }
}