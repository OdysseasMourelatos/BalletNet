<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Global Scripts: Bootstrap & Language Detection -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    (function () {
        const userLang = navigator.language || navigator.userLanguage;
        const lang = userLang.startsWith("el") ? "el" : "en";
        document.documentElement.lang = lang;

        document.querySelectorAll("[data-el]").forEach(function (el) {
            const translatedText = el.getAttribute("data-" + lang);
            if (translatedText) {
                el.textContent = translatedText;
            }
        });
    })();
</script>