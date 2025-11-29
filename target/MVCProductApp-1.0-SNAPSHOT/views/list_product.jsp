<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, models.Product" %>
<% String base = request.getContextPath(); %>
<% List<Product> products = (List<Product>) request.getAttribute("products"); %>
<% String message = (String) request.getAttribute("message"); %>
<% String keyword = (String) request.getAttribute("keyword"); %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Daftar Produk</title>
    <style>
        :root {
            --primary: #cc0000;
            --primary-hover: #990000;
            --bg: #f3f4f6;
            --surface: #ffffff;
            --text: #111827;
            --text-mute: #6b7280;
            --border: #e5e7eb;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            padding: 30px;
            margin: 0;
        }
        .container { max-width: 1100px; margin: 0 auto; }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .title h2 { margin: 0; font-size: 20px; font-weight: 700; color: #111827; }
        .title span { font-size: 14px; color: var(--text-mute); font-weight: normal; }

        .controls { display: flex; gap: 10px; }

        .search-input {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 13px;
            width: 220px;
        }
        .search-input:focus { outline: 2px solid var(--primary); border-color: transparent; }

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
        }
        .btn-red { background: var(--primary); color: white; }
        .btn-red:hover { background: var(--primary-hover); }
        .btn-grey { background: white; border: 1px solid #d1d5db; color: #374151; }
        .btn-grey:hover { background: #f9fafb; }

        .table-wrapper {
            background: var(--surface);
            border-radius: 8px;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            overflow: hidden;
        }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        
        th {
            background: #f9fafb;
            padding: 14px 16px;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #4b5563;
            font-weight: 600;
            border-bottom: 1px solid var(--border);
        }
        td {
            padding: 14px 16px;
            font-size: 14px;
            color: #1f2937;
            border-bottom: 1px solid var(--border);
        }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #fcfcfc; }

        .action-links a { color: #4b5563; text-decoration: none; font-weight: 500; font-size: 13px; margin-right: 10px; }
        .action-links a:hover { color: var(--primary); }
        .delete-btn {
            background: none; border: none; padding: 0; color: #ef4444; font-weight: 500; font-size: 13px; cursor: pointer;
        }
        .delete-btn:hover { text-decoration: underline; color: #b91c1c; }

        .alert {
            background: #1f2937; color: white; padding: 10px 15px; border-radius: 6px;
            font-size: 13px; margin-bottom: 20px; display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
        
        <% if (message != null) { %>
           
            <div class="alert"><%= message %></div>
        <% } %>

        <div class="top-bar">
            <div class="title">
                <h2>Product Inventory</h2>
                <span>Manage all items in one place</span>
            </div>
            <div class="controls">
                <a href="<%= base %>/home" class="btn-sm btn-grey">Kembali</a>
                <form action="<%= base %>/product" method="get" style="display:flex; gap:5px;">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" class="search-input" placeholder="Cari nama/kategori..." value="<%= keyword!=null?keyword:"" %>">
                    <button type="submit" class="btn-sm btn-grey">Cari</button>
                </form>
                <a href="<%= base %>/product?action=add" class="btn-sm btn-red">+ Tambah Produk</a>
            </div>
        </div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th style="width: 60px;">ID</th>
                        <th>Nama Produk</th>
                        <th>Kategori</th>
                        <th>Harga</th>
                        <th>Stok</th>
                        <th>Deskripsi</th>
                        <th style="text-align: right;">Opsi</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (products != null && !products.isEmpty()) { 
                         for (Product p : products) { %>
                    <tr>
                        <td style="color: #9ca3af;">#<%= p.getId() %></td>
                        <td style="font-weight: 500;"><%= p.getName() %></td>
                        <td><span style="background: #e5e7eb; padding: 2px 8px; border-radius: 10px; font-size: 11px; color: #374151;"><%= p.getCategory() %></span></td>
                        <td>Rp <%= String.format("%,.0f", p.getPrice()) %></td>
                        <td>
                            <span style="<%= p.getStock() < 10 ? "color:#b91c1c; font-weight:bold;" : "color:#047857;" %>">
                                <%= p.getStock() %>
                            </span>
                        </td>
                        <td style="color: #6b7280; font-size: 13px; max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= p.getDescription() %></td>
                        <td class="action-links" style="text-align: right;">
                            <a href="<%= base %>/product?action=edit&id=<%= p.getId() %>">Edit</a>
                            <form action="<%= base %>/product" method="post" style="display:inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button type="submit" class="delete-btn" onclick="return confirm('Hapus data ini secara permanen?')">Hapus</button>
                            </form>
                        </td>
                    </tr>
                    <% }} else { %>
                    <tr><td colspan="7" style="text-align:center; padding: 30px; color: #9ca3af;">Data tidak ditemukan.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>