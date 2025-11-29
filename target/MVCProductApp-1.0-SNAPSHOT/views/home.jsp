<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String base = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard-Tugas MVC</title>
    <style>
        :root {
            --primary: #cc0000;
            --primary-hover: #990000;
            --bg-body: #f3f4f6;
            --card-bg: #ffffff;
            --text-main: #1f2937;
            --text-sub: #6b7280;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 550px;
            padding: 20px;
        }

        .card {
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            padding: 45px;
            text-align: center;
            border-top: 5px solid var(--primary);
        }

        .brand-logo {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 25px;
            color: var(--primary);
            letter-spacing: -1px;
            text-transform: uppercase;
        }

        h1 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--text-main);
        }

        p {
            color: var(--text-sub);
            margin-bottom: 35px;
            font-size: 14px;
            line-height: 1.6;
        }

        .btn {
            display: block;
            padding: 14px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
            margin-bottom: 12px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            box-shadow: 0 4px 6px -1px rgba(204, 0, 0, 0.2);
        }
        .btn-primary:hover { background-color: var(--primary-hover); }

        .btn-outline {
            background-color: white;
            color: var(--text-main);
            border: 1px solid #e5e7eb;
        }
        .btn-outline:hover { background-color: #f9fafb; border-color: #d1d5db; }

        .footer {
            margin-top: 25px;
            font-size: 13px;
            color: #9ca3af;
            font-weight: 500;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="brand-logo">TUGAS MVC SULTHONIKA</div>
            
            <h1>Product Inventory System</h1>
            <p>Kelola data produk perusahaan dengan aman, terstruktur, dan efisien dalam satu dashboard terintegrasi.</p>
            
            <div class="action-group">
                <a href="<%= base %>/product?action=list" class="btn btn-primary">Lihat Data Produk</a>
                <a href="<%= base %>/product?action=add" class="btn btn-outline">Input Produk Baru</a>
            </div>
        </div>
        
        <div class="footer">
            Dibuat oleh Sulthonika
        </div>
    </div>
</body>
</html>