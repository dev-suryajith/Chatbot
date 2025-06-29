// Unified slider initialization function
function initializeSlider(sliderId, valuesId, minInputId, maxInputId) {
    const slider = document.getElementById(sliderId);
    const sliderValues = document.getElementById(valuesId);
    const minInput = document.getElementById(minInputId);
    const maxInput = document.getElementById(maxInputId);

    // Create the slider
    noUiSlider.create(slider, {
        start: [
            parseFloat(minInput.value) || 0,
            parseFloat(maxInput.value) || 100
        ],
        connect: true,
        step: 1,
        range: {
            'min': 0,
            'max': 100
        },
        format: {
            to: function (value) {
                return Math.round(value);
            },
            from: function (value) {
                return parseInt(value);
            }
        }
    });

    // Update the display values and hidden inputs when slider changes
    slider.noUiSlider.on('update', function (values, handle) {
        const min = values[0];
        const max = values[1];

        sliderValues.textContent = `${min}% - ${max}%`;
        minInput.value = min;
        maxInput.value = max;
    });

    // Trigger search when slider changes (but not during dragging)
    slider.noUiSlider.on('change', function() {
        // Check if dashboardManager exists before calling performSearch
        if (window.dashboardManager) {
            window.dashboardManager.performSearch();
        }
    });

    return slider;
}

class DashboardManager {
    constructor() {
        this.endpoints = {
            search: "{% url 'search_applications' %}",
            updateStatus: "{% url 'update_status' %}",
            updateCourse: "{% url 'update_course' %}"
        };
        this.currentPage = 1;
        this.searchTimeout = null;
        this.isLoading = false;
        this.initializeEventListeners();

        // Instead of calling a separate method for sliders,
        // we'll use the unified slider initialization in the DOM loaded event
    }

    initializeEventListeners() {
        // Search and filter handlers
        const searchInput = document.querySelector('.search-input');
        searchInput.addEventListener('input', () => {
            clearTimeout(this.searchTimeout);
            this.searchTimeout = setTimeout(() => this.performSearch(), 300);
        });

        document.querySelectorAll('.filter-select').forEach(input => {
            input.addEventListener('change', () => this.performSearch());
        });

        document.getElementById('clearFiltersBtn').addEventListener('click', () => {
            document.getElementById('searchForm').reset();

            // Reset all sliders to default values
            if (this.marksSlider && this.marksSlider.noUiSlider) {
                this.marksSlider.noUiSlider.set([0, 100]);
            }

            if (window.tenthMarksSlider && window.tenthMarksSlider.noUiSlider) {
                window.tenthMarksSlider.noUiSlider.set([0, 100]);
            }

            if (window.twelfthMarksSlider && window.twelfthMarksSlider.noUiSlider) {
                window.twelfthMarksSlider.noUiSlider.set([0, 100]);
            }

            this.performSearch();
        });

        // Modal handlers
        document.querySelectorAll('.modal-close').forEach(btn => {
            btn.addEventListener('click', () => this.closeModals());
        });

        // Form submissions
        const statusForm = document.getElementById('statusForm');
        if (statusForm) {
            statusForm.addEventListener('submit', this.handleStatusUpdate.bind(this));
        }

        const courseForm = document.getElementById('courseForm');
        if (courseForm) {
            courseForm.addEventListener('submit', this.handleCourseUpdate.bind(this));
        }

        // Close modals when clicking outside
        window.addEventListener('click', (e) => {
            if (e.target.classList.contains('modal')) {
                this.closeModals();
            }
        });

        // Initial search
        this.performSearch();
    }

    showLoading() {
        this.isLoading = true;
        const applicationsSection = document.querySelector('.applications-section');
        // Loading indicator implementation can be added here if needed
    }

    hideLoading() {
        this.isLoading = false;
    }

    async performSearch(page = 1) {
        if (this.isLoading) return;

        this.showLoading();
        const searchParams = new URLSearchParams();

        // Get search input value
        const searchInput = document.querySelector('.search-input');
        if (searchInput) {
            searchParams.append('search', searchInput.value);
        }

        // Get status value
        const statusSelect = document.querySelector('select[name="status"]');
        if (statusSelect) {
            searchParams.append('status', statusSelect.value);
        }

        // Get course value
        const courseSelect = document.querySelector('select[name="course"]');
        if (courseSelect) {
            searchParams.append('course', courseSelect.value);
        }

        // Get marks filter values
        // First check if we're using the unified marks slider
        const minMarksInput = document.querySelector('input[name="min_marks"]');
        const maxMarksInput = document.querySelector('input[name="max_marks"]');

        if (minMarksInput && maxMarksInput) {
            searchParams.append('min_marks', minMarksInput.value);
            searchParams.append('max_marks', maxMarksInput.value);
        }

        // Check if we're using the separate 10th/12th marks sliders
        const tenthMinInput = document.getElementById('tenthMinMarksInput');
        const tenthMaxInput = document.getElementById('tenthMaxMarksInput');

        if (tenthMinInput && tenthMaxInput) {
            searchParams.append('tenth_min_marks', tenthMinInput.value);
            searchParams.append('tenth_max_marks', tenthMaxInput.value);
        }

        const twelfthMinInput = document.getElementById('twelfthMinMarksInput');
        const twelfthMaxInput = document.getElementById('twelfthMaxMarksInput');

        if (twelfthMinInput && twelfthMaxInput) {
            searchParams.append('twelfth_min_marks', twelfthMinInput.value);
            searchParams.append('twelfth_max_marks', twelfthMaxInput.value);
        }

        // Add page
        searchParams.append('page', page);

        try {
            const response = await fetch(`${this.endpoints.search}?${searchParams.toString()}`);
            if (!response.ok) throw new Error('Search request failed');

            const data = await response.json();
            this.updateSearchResults(data);
            this.updatePagination(data);
        } catch (error) {
            this.showNotification('Error performing search: ' + error.message, 'error');
        } finally {
            this.hideLoading();
        }
    }

    updateSearchResults(data) {
        const applicationsSection = document.querySelector('.applications-section');
        if (!applicationsSection) return;

        // Update results count
        const countTitle = applicationsSection.querySelector('.section-title') ||
            document.createElement('h2');
        countTitle.className = 'section-title';
        countTitle.textContent = `Applications (${data.total_results})`;

        if (!applicationsSection.querySelector('.section-title')) {
            applicationsSection.insertBefore(countTitle, applicationsSection.firstChild);
        }

        // Create or update applications grid
        let applicationsGrid = applicationsSection.querySelector('.applications-grid');
        if (!applicationsGrid) {
            applicationsGrid = document.createElement('div');
            applicationsGrid.className = 'applications-grid';
            applicationsSection.appendChild(applicationsGrid);
        }

        if (data.results.length === 0) {
            applicationsGrid.innerHTML = `
                <div class="empty-state">
                    <i class="icon-empty"></i>
                    <p>No applications found matching your criteria.</p>
                </div>
            `;
            return;
        }

        applicationsGrid.innerHTML = data.results.map(app => this.createApplicationCard(app)).join('');
        this.initializeCardEventListeners();
    }

    createApplicationCard(app) {
        return `
            <article class="application-card" data-application-id="${app.id}">
                <div class="card-header">
                    <h3 class="application-number">
                        Application #${app.application_number}
                    </h3>
                    <div class="status-badge status-${app.status}" id="status-${app.id}">
                        ${app.status.charAt(0).toUpperCase() + app.status.slice(1)}
                    </div>
                </div>

                <div class="card-content">
                    <div class="applicant-details">
                        <div class="detail-group">
                            <label>Name</label>
                            <span>${app.full_name}</span>
                        </div>
                        <div class="detail-group">
                            <label>Email</label>
                            <span>${app.email}</span>
                        </div>
                        <div class="detail-group">
                            <label>Phone</label>
                            <span>${app.phone_number}</span>
                        </div>
                        <div class="detail-group">
                            <label>10th Overall Percentage</label>
                            <span>${app.sslc_percentage}</span>
                        </div>
                        <div class="detail-group">
                            <label>12th Overall Percentage</label>
                            <span>${app.total_percentage}</span>
                        </div>
                        <div class="detail-group">
                            <label>Allotted Course</label>
                            <span id="course-${app.id}">
                                ${app.alloted_course || "Not Allocated"}
                            </span>
                        </div>
                        <div class="detail-group">
                            <label>Course Preferences</label>
                            <span class="preferences">
                                1. ${app.priority_1}
                                2. ${app.priority_2}
                                3. ${app.priority_3}
                            </span>
                        </div>
                    </div>
                </div>

                <div class="card-actions">
                    <button class="btn btn-outline update-status-btn"
                        data-application-id="${app.id}"
                        data-current-status="${app.status}">
                        Update Status
                    </button>
                    <button class="btn btn-outline allot-course-btn"
                        data-application-id="${app.id}"
                        data-current-course="${app.alloted_course || ''}"
                        data-priority1="${app.priority_1}"
                        data-priority2="${app.priority_2}"
                        data-priority3="${app.priority_3}">
                        Allot Course
                    </button>
                    <a href="/application_details/${app.id}/" class="btn btn-primary" style="text-decoration:none">
                        View Details
                    </a>
                </div>
            </article>
        `;
    }

    updatePagination(data) {
        const applicationsSection = document.querySelector('.applications-section');
        if (!applicationsSection) return;

        let paginationContainer = document.querySelector('.pagination');
        if (!paginationContainer) {
            paginationContainer = document.createElement('div');
            paginationContainer.className = 'pagination';
            applicationsSection.appendChild(paginationContainer);
        }

        if (data.total_pages > 1) {
            paginationContainer.innerHTML = `
                <button class="btn btn-outline"
                    ${data.current_page === 1 ? 'disabled' : ''}
                    onclick="window.dashboardManager.performSearch(${data.current_page - 1})">
                    Previous
                </button>
                <span class="pagination-info">
                    Page ${data.current_page} of ${data.total_pages}
                </span>
                <button class="btn btn-outline"
                    ${data.current_page === data.total_pages ? 'disabled' : ''}
                    onclick="window.dashboardManager.performSearch(${data.current_page + 1})">
                    Next
                </button>
            `;
        } else {
            paginationContainer.innerHTML = '';
        }
    }

    initializeCardEventListeners() {
        document.querySelectorAll('.update-status-btn').forEach(btn => {
            btn.addEventListener('click', (e) => this.openStatusModal(e.target));
        });

        document.querySelectorAll('.allot-course-btn').forEach(btn => {
            btn.addEventListener('click', (e) => this.openCourseModal(e.target));
        });
    }

    openStatusModal(button) {
        const applicationId = button.dataset.applicationId;
        const currentStatus = button.dataset.currentStatus;
        const statusModal = document.getElementById('statusModal');

        if (!statusModal) return;

        document.getElementById('statusApplicationId').value = applicationId;

        const statusRadio = document.querySelector(`input[name="status"][value="${currentStatus}"]`);
        if (statusRadio) {
            statusRadio.checked = true;
        }

        statusModal.style.display = 'block';
    }

    openCourseModal(button) {
        const {
            applicationId,
            currentCourse,
            priority1,
            priority2,
            priority3
        } = button.dataset;

        const courseModal = document.getElementById('courseModal');
        if (!courseModal) return;

        document.getElementById('courseApplicationId').value = applicationId;

        const courseOptions = document.getElementById('courseOptions');
        if (courseOptions) {
            const uniqueCourses = [...new Set([priority1, priority2, priority3, 'Not Allocated'])];
            const optionsHtml = uniqueCourses
                .map(course => this.createCourseOption(course, currentCourse))
                .join('');

            courseOptions.innerHTML = optionsHtml;
        }

        courseModal.style.display = 'block';
    }

    createCourseOption(course, currentCourse) {
        const value = course === 'Not Allocated' ? '' : course;
        return `
            <label class="course-option ${currentCourse === course ? 'selected' : ''}">
                <input type="radio" name="allotted_course" value="${value}"
                       ${currentCourse === course ? 'checked' : ''}>
                <span>${course}</span>
            </label>
        `;
    }

    closeModals() {
        document.querySelectorAll('.modal').forEach(modal => {
            modal.style.display = 'none';
        });
    }

    async handleStatusUpdate(e) {
        e.preventDefault();
        const statusApplicationId = document.getElementById('statusApplicationId');
        const statusChecked = document.querySelector('input[name="status"]:checked');

        if (!statusApplicationId || !statusChecked) {
            this.showNotification('Missing required fields', 'error');
            return;
        }

        const formData = {
            application_id: statusApplicationId.value,
            status: statusChecked.value
        };

        try {
            const response = await this.makeRequest(this.endpoints.updateStatus, formData);
            if (response.success) {
                this.updateStatusUI(formData.application_id, formData.status);
                this.showNotification('Status updated successfully');
                this.closeModals();
            }
        } catch (error) {
            this.showNotification(error.message, 'error');
        }
    }

    async handleCourseUpdate(e) {
        e.preventDefault();
        const courseApplicationId = document.getElementById('courseApplicationId');
        const courseChecked = document.querySelector('input[name="allotted_course"]:checked');

        if (!courseApplicationId || !courseChecked) {
            this.showNotification('Missing required fields', 'error');
            return;
        }

        const formData = {
            application_id: courseApplicationId.value,
            allotted_course: courseChecked.value
        };

        try {
            const response = await this.makeRequest(this.endpoints.updateCourse, formData);
            if (response.success) {
                this.updateCourseUI(formData.application_id, formData.allotted_course);
                this.showNotification('Course allotment updated successfully');
                this.closeModals();
            }
        } catch (error) {
            this.showNotification(error.message, 'error');
        }
    }

    async makeRequest(url, data) {
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': this.getCookie('csrftoken')
            },
            body: JSON.stringify(data)
        });

        if (!response.ok) {
            throw new Error('Request failed');
        }

        return await response.json();
    }

    updateStatusUI(applicationId, status) {
        const statusElement = document.getElementById(`status-${applicationId}`);
        if (statusElement) {
            statusElement.textContent = status.charAt(0).toUpperCase() + status.slice(1);
            statusElement.className = `status-badge status-${status}`;
        }

        const button = document.querySelector(`.update-status-btn[data-application-id="${applicationId}"]`);
        if (button) {
            button.dataset.currentStatus = status;
        }
    }

    updateCourseUI(applicationId, course) {
        const courseElement = document.getElementById(`course-${applicationId}`);
        if (courseElement) {
            courseElement.textContent = course || "Not Allocated";
        }

        const button = document.querySelector(`.allot-course-btn[data-application-id="${applicationId}"]`);
        if (button) {
            button.dataset.currentCourse = course;
        }
    }

    showNotification(message, type = 'success') {
        if (typeof Toastify !== 'undefined') {
            Toastify({
                text: message,
                duration: 3000,
                gravity: "top",
                position: "right",
                backgroundColor: type === 'success' ? "#28a745" : "#dc3545",
                stopOnFocus: true
            }).showToast();
        } else {
            // Fallback if Toastify is not available
            alert(message);
        }
    }

    getCookie(name) {
        const value = `; ${document.cookie}`;
        const parts = value.split(`; ${name}=`);
        if (parts.length === 2) return parts.pop().split(';').shift();
    }
}

// Initialize everything when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize 10th marks slider
    window.tenthMarksSlider = initializeSlider(
        'tenthMarksSlider',
        'tenthSliderValues',
        'tenthMinMarksInput',
        'tenthMaxMarksInput'
    );

    // Initialize 12th marks slider
    window.twelfthMarksSlider = initializeSlider(
        'twelfthMarksSlider',
        'twelfthSliderValues',
        'twelfthMinMarksInput',
        'twelfthMaxMarksInput'
    );

    // Initialize the general marks slider if it exists
    const marksSlider = document.getElementById('marksSlider');
    if (marksSlider) {
        const minMarksInput = document.getElementById('minMarksInput');
        const maxMarksInput = document.getElementById('maxMarksInput');
        const sliderValueDisplay = document.getElementById('sliderValues');

        if (minMarksInput && maxMarksInput && sliderValueDisplay) {
            window.mainMarksSlider = initializeSlider(
                'marksSlider',
                'sliderValues',
                'minMarksInput',
                'maxMarksInput'
            );
        }
    }

    // Initialize the dashboard manager
    window.dashboardManager = new DashboardManager();

    // Store reference to sliders in dashboard manager for reset functionality
    if (window.dashboardManager) {
        window.dashboardManager.marksSlider = window.mainMarksSlider;
    }
});