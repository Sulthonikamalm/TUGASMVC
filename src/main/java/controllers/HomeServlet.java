package controllers;

// PERUBAHAN DI SINI: Menggunakan 'jakarta', bukan 'javax'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
* HomeServlet: Controller sederhana untuk mengarahkan ke halaman menu utama.
*/
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request ke tampilan JSP
        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}