using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace Prueba.Controllers
{
    public class PdfController : Controller
    {
        private readonly PdfService _pdfService;

        public PdfController(PdfService pdfService)
        {
            _pdfService = pdfService;
        }

        public IActionResult GeneratePdf()
        {
            var pdfContent = _pdfService.CreatePdf("Sample PDF", "Este es un contenido de ejemplo generado con QuestPDF.");
            return File(pdfContent, "application/pdf", "documento.pdf");
        }
        public IActionResult Index()
        {
            return View();
        }
    }
}