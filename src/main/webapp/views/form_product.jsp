<%@ page import="models.Product" %>
<% String base = request.getContextPath(); %>
<% Product product = (Product) request.getAttribute("product"); %>
<% String error = (String) request.getAttribute("error"); %>
<% 
    boolean edit = (product != null && product.getId() > 0);
    if (product == null) product = new Product(); 
    
    String currentCat = (product.getCategory() != null) ? product.getCategory() : "";
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title><%= edit ? "Edit Data" : "Input Data" %></title>
    <style>
        :root {
            --primary: #cc0000;
            --bg: #f3f4f6;
            --surface: #ffffff;
            --text: #1f2937;
            --border: #d1d5db;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .form-card {
            background: var(--surface);
            width: 100%;
            max-width: 480px;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            border-top: 4px solid var(--primary);
        }

        h2 { margin: 0 0 5px 0; font-size: 20px; font-weight: 700; color: #111827; }
        p.subtitle { margin: 0 0 25px 0; color: #6b7280; font-size: 13px; }

        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; font-size: 13px; font-weight: 600; color: #374151; }
        
        input, textarea, select {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid var(--border);
            font-size: 14px;
            box-sizing: border-box;
            font-family: inherit;
            transition: all 0.2s;
            background-color: #fff;
        }
        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(204, 0, 0, 0.1);
        }
        textarea { resize: vertical; min-height: 80px; }

        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }

        .btn-submit {
            width: 100%;
            background: var(--primary);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-submit:hover { background-color: #990000; }

        .btn-cancel {
            display: block; text-align: center; margin-top: 15px;
            color: #6b7280; font-size: 13px; text-decoration: none;
        }
        .btn-cancel:hover { color: #1f2937; }

        .error-banner {
            background-color: #fef2f2;
            border: 1px solid #fee2e2;
            color: #991b1b;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 13px;
            display: flex; align-items: center; gap: 10px;
        }
    </style>
</head>
<body>
    <div class="form-card">
        <h2><%= edit ? "Perbarui Data" : "Input Produk Baru" %></h2>
        <p class="subtitle">Lengkapi formulir di bawah ini dengan data yang valid.</p>
        
        <% if (error != null) { %>
            <div class="error-banner">
                <span style="font-size: 16px;">??</span>
                <strong>Error:</strong> <%= error %>
            </div>
        <% } %>

        <form action="<%= base %>/product" method="post">
            <input type="hidden" name="action" value="<%= edit ? "edit" : "add" %>">
            <% if (edit) { %><input type="hidden" name="id" value="<%= product.getId() %>"><% } %>

            <div class="form-group">
                <label>Nama Produk</label>
                <input type="text" name="name" placeholder="Contoh: Laptop Gaming" value="<%= product.getName()!=null?product.getName():"" %>">
            </div>

            <div class="form-group">
                <label>Kategori</label>
                <select name="category">
                    <option value="">Pilih Kategori</option>
                    <option value="Alat Tulis" <%= currentCat.equals("Alat Tulis") || currentCat.equals("Stationery") ? "selected" : "" %>>Alat Tulis</option>
                    <option value="Elektronik" <%= currentCat.equals("Elektronik") ? "selected" : "" %>>Elektronik</option>
                    <option value="Pakaian" <%= currentCat.equals("Pakaian") ? "selected" : "" %>>Pakaian</option>
                    <option value="Makanan" <%= currentCat.equals("Makanan") ? "selected" : "" %>>Makanan</option>
                    <option value="Lainnya" <%= currentCat.equals("Lainnya") ? "selected" : "" %>>Lainnya</option>
                </select>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Harga (Rp)</label>
                    <input type="number" name="price" placeholder="0" value="<%= product.getPrice() > 0 ? (long)product.getPrice() : "" %>">
                </div>
                <div class="form-group">
                    <label>Stok Unit</label>
                    <input type="number" name="stock" placeholder="0" value="<%= product.getStock() >= 0 ? product.getStock() : "" %>">
                </div>
            </div>

            <div class="form-group">
                <label>Keterangan</label>
                <textarea name="description" placeholder="Deskripsi singkat produk..."><%= product.getDescription()!=null?product.getDescription():"" %></textarea>
            </div>

            <button type="submit" class="btn-submit"><%= edit ? "Simpan Perubahan" : "Simpan Data" %></button>
            <a href="<%= base %>/product?action=list" class="btn-cancel">Batalkan</a>
        </form>
    </div>
</body>
</html>