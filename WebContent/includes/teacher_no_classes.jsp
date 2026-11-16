<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="empty-state text-center py-5 px-3 mx-auto">
    <!-- Εικονίδιο -->
    <div class="es-badge mb-5">
        <i class="bi bi-journal-x" aria-hidden="true"></i>
    </div>

    <!-- Τίτλος & περιγραφή -->
    <h3 class="es-title fw-bold mb-3">Δεν βρέθηκαν ενεργά τμήματα</h3>
    <p class="es-text text-muted mb-4">
        Δεν υπάρχουν τμήματα διδασκαλίας ανατεθειμένα στο προφίλ σας για την τρέχουσα περίοδο.
        Μόλις γίνει η ανάθεση, θα ενεργοποιηθούν αυτόματα οι παρακάτω λειτουργίες.
    </p>

    <!-- Τι θα ενεργοποιηθεί -->
    <div class="row g-3 mb-4 text-start">
        <div class="col-sm-6">
            <div class="es-feature">
                <span class="es-ico"><i class="bi bi-journal-check" aria-hidden="true"></i></span>
                <div class="lh-sm">
                    <div class="fw-semibold small">Πρόοδος ύλης τμήματος</div>
                    <div class="text-muted" style="font-size: .78rem;">Κάλυψη ανά ενότητα RAD</div>
                </div>
                <i class="bi bi-lock-fill es-lock" aria-hidden="true"></i>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="es-feature">
                <span class="es-ico"><i class="bi bi-people-fill" aria-hidden="true"></i></span>
                <div class="lh-sm">
                    <div class="fw-semibold small">Αξιολόγηση μαθητριών</div>
                    <div class="text-muted" style="font-size: .78rem;">Προσωπική πρόοδος</div>
                </div>
                <i class="bi bi-lock-fill es-lock" aria-hidden="true"></i>
            </div>
        </div>
    </div>

    <!-- Κατάσταση λογαριασμού -->
    <div class="d-inline-flex align-items-center gap-2 px-3 py-2 rounded-pill bg-light border border-secondary-subtle small text-muted mb-4 shadow-sm">
        <span class="spinner-grow spinner-grow-sm text-ballet" style="width: .6rem; height: .6rem;" aria-hidden="true"></span>
        <span>Κατάσταση λογαριασμού: <strong class="text-dark">RAD Certified Instructor</strong> · Αναμονή ανάθεσης</span>
    </div>

    <!-- Ενέργειες -->
    <div class="d-flex flex-wrap justify-content-center gap-3 pt-1">
        <a href="mailto:secretariat@balletarts.gr?subject=Ανάθεση%20Τμημάτων%20Διδασκαλίας%20-%20BalletNet"
        class="btn btn-ballet rounded-pill px-4 py-2 fw-semibold shadow-sm d-inline-flex align-items-center gap-2">
            <i class="bi bi-envelope"></i>
            <span>Επικοινωνία με Γραμματεία</span>
        </a>

        <a href="<%=request.getContextPath()%>/servlet/balletnet.controllers.ClassProgressServlet"
        class="btn btn-outline-secondary rounded-pill px-4 py-2 fw-semibold d-inline-flex align-items-center gap-2">
            <i class="bi bi-arrow-clockwise"></i>
            <span>Ανανέωση δεδομένων</span>
        </a>
    </div>
</div>