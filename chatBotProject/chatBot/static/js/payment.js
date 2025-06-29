document.addEventListener('DOMContentLoaded', function() {
    // Payment method switching
    const paymentMethods = document.querySelectorAll('input[name="payment_method"]');
    const methodForms = {
        'credit': document.getElementById('credit-form'),
        'debit': document.getElementById('credit-form'),
        'paypal': document.getElementById('paypal-form'),
        'bank': document.getElementById('bank-form'),
        'crypto': document.getElementById('crypto-form')
    };

    // Show the initially selected method form
    const initialMethod = document.querySelector('input[name="payment_method"]:checked');
    if (initialMethod) {
        const type = initialMethod.getAttribute('data-type');
        showSelectedMethodForm(type);
    }

    // Add event listeners for payment method selection
    paymentMethods.forEach(method => {
        method.addEventListener('change', function() {
            const type = this.getAttribute('data-type');
            showSelectedMethodForm(type);
        });
    });

    function showSelectedMethodForm(type) {
        // Hide all method forms
        Object.values(methodForms).forEach(form => {
            if (form) form.style.display = 'none';
        });

        // Show the selected method form
        if (methodForms[type]) {
            methodForms[type].style.display = 'block';
        }
    }

    // Credit card formatting
    const cardNumberInput = document.querySelector('input[data-card-format="true"]');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 16) value = value.slice(0, 16);

            // Format with spaces every 4 digits
            let formattedValue = '';
            for (let i = 0; i < value.length; i++) {
                if (i > 0 && i % 4 === 0) {
                    formattedValue += ' ';
                }
                formattedValue += value[i];
            }

            e.target.value = formattedValue;
        });
    }

    // Expiry date formatting (MM/YY)
    const expiryDateInput = document.querySelector('input[placeholder="MM/YY"]');
    if (expiryDateInput) {
        expiryDateInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 4) value = value.slice(0, 4);

            // Format as MM/YY
            if (value.length > 2) {
                value = value.slice(0, 2) + '/' + value.slice(2);
            }

            e.target.value = value;

            // Validate month input
            if (value.length >= 2) {
                const month = parseInt(value.substring(0, 2));
                if (month < 1 || month > 12) {
                    // Visual feedback for invalid month
                    e.target.classList.add('invalid-input');
                } else {
                    e.target.classList.remove('invalid-input');
                }
            }
        });
    }

    // Form validation
    const paymentForm = document.getElementById('payment-form');
    if (paymentForm) {
        paymentForm.addEventListener('submit', function(e) {
            e.preventDefault();

            let isValid = true;
            const selectedMethod = document.querySelector('input[name="payment_method"]:checked');
            const methodType = selectedMethod ? selectedMethod.getAttribute('data-type') : null;

            // Basic validation based on payment method
            if (methodType === 'credit' || methodType === 'debit') {
                const cardNumber = document.querySelector('input[placeholder="•••• •••• •••• ••••"]').value;
                const cardHolder = document.querySelector('input[placeholder="Cardholder Name"]').value;
                const expiryDate = document.querySelector('input[placeholder="MM/YY"]').value;
                const cvv = document.querySelector('input[placeholder="CVV"]').value;

                if (!cardNumber || !cardHolder || !expiryDate || !cvv) {
                    isValid = false;
                    showValidationError("Please fill in all card details");
                } else if (cardNumber.replace(/\s/g, '').length < 16) {
                    isValid = false;
                    showValidationError("Please enter a valid card number");
                } else if (expiryDate.length < 5) {
                    isValid = false;
                    showValidationError("Please enter a valid expiry date");
                } else if (cvv.length < 3) {
                    isValid = false;
                    showValidationError("Please enter a valid security code");
                }
            } else if (methodType === 'paypal') {
                const email = document.querySelector('input[placeholder="PayPal Email"]').value;
                if (!email || !isValidEmail(email)) {
                    isValid = false;
                    showValidationError("Please enter a valid PayPal email address");
                }
            } else if (methodType === 'bank') {
                const accountName = document.querySelector('input[placeholder="Account Holder Name"]').value;
                const accountNumber = document.querySelector('input[placeholder="Account Number"]').value;
                const routingNumber = document.querySelector('input[placeholder="Routing Number"]').value;
                const bankName = document.querySelector('input[placeholder="Bank Name"]').value;

                if (!accountName || !accountNumber || !routingNumber || !bankName) {
                    isValid = false;
                    showValidationError("Please fill in all bank details");
                }
            }

            // Check billing address
            const billingAddress = document.querySelector('textarea[placeholder="Billing Address"]').value;
            if (!billingAddress) {
                isValid = false;
                showValidationError("Please enter your billing address");
            }

            // Check payment amount
            const amount = document.querySelector('input[name="amount"]').value;
            if (!amount || isNaN(amount) || parseFloat(amount) <= 0) {
                isValid = false;
                showValidationError("Please enter a valid payment amount");
            }

            // Submit the form if valid
            if (isValid) {
                // Show loading state
                const submitButton = document.querySelector('.btn-pay');
                submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                submitButton.disabled = true;

                // In a real application, you would handle the form submission
                // Either via AJAX or by allowing the form to submit normally

                // Simulate processing delay for demo
                setTimeout(() => {
                    paymentForm.submit();
                }, 1500);
            }
        });
    }

    function showValidationError(message) {
        // Remove any existing error message
        const existingError = document.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // Create and add the new error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.textContent = message;

        const formContainer = document.querySelector('.payment-form-container');
        formContainer.insertBefore(errorDiv, formContainer.firstChild);

        // Scroll to error
        errorDiv.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function isValidEmail(email) {
        const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }

    // Amount formatting
    const amountInput = document.querySelector('input[name="amount"]');
    if (amountInput) {
        amountInput.addEventListener('blur', function(e) {
            const value = parseFloat(e.target.value);
            if (!isNaN(value)) {
                e.target.value = value.toFixed(2);
            }
        });
    }
});