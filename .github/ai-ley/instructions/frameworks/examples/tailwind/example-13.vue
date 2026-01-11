<template>
  <div class="max-w-2xl mx-auto p-6">
    <!-- Dynamic classes with Vue -->
    <div
      :class="[
        'p-4 rounded-lg border transition-all duration-200',
        alertType === 'success' ? 'bg-green-50 border-green-200 text-green-800' : '',
        alertType === 'error' ? 'bg-red-50 border-red-200 text-red-800' : '',
        alertType === 'warning' ? 'bg-yellow-50 border-yellow-200 text-yellow-800' : '',
        isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 -translate-y-2',
      ]"
      v-if="showAlert"
    >
      <div class="flex items-center">
        <svg
          :class="[
            'w-5 h-5 mr-2',
            alertType === 'success' ? 'text-green-400' : '',
            alertType === 'error' ? 'text-red-400' : '',
            alertType === 'warning' ? 'text-yellow-400' : '',
          ]"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            fill-rule="evenodd"
            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
            clip-rule="evenodd"
          ></path>
        </svg>
        {{ alertMessage }}
      </div>
    </div>

    <!-- Form with Tailwind validation styles -->
    <form @submit.prevent="submitForm" class="mt-6 space-y-6">
      <div>
        <label for="name" class="form-label">Name</label>
        <input
          v-model="form.name"
          :class="[
            'form-input',
            errors.name ? 'border-red-300 focus:border-red-500 focus:ring-red-500' : '',
          ]"
          type="text"
          id="name"
          placeholder="Enter your name"
        />
        <p v-if="errors.name" class="form-error">{{ errors.name }}</p>
      </div>

      <div>
        <label for="email" class="form-label">Email</label>
        <input
          v-model="form.email"
          :class="[
            'form-input',
            errors.email ? 'border-red-300 focus:border-red-500 focus:ring-red-500' : '',
          ]"
          type="email"
          id="email"
          placeholder="Enter your email"
        />
        <p v-if="errors.email" class="form-error">{{ errors.email }}</p>
      </div>

      <button
        type="submit"
        :disabled="isSubmitting"
        :class="['btn w-full', isSubmitting ? 'btn-secondary' : 'btn-primary']"
      >
        <svg
          v-if="isSubmitting"
          class="animate-spin -ml-1 mr-3 h-5 w-5"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle
            class="opacity-25"
            cx="12"
            cy="12"
            r="10"
            stroke="currentColor"
            stroke-width="4"
          ></circle>
          <path
            class="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          ></path>
        </svg>
        {{ isSubmitting ? 'Submitting...' : 'Submit' }}
      </button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        name: '',
        email: '',
      },
      errors: {},
      isSubmitting: false,
      showAlert: false,
      alertType: 'success',
      alertMessage: '',
      isVisible: false,
    };
  },

  methods: {
    validateForm() {
      this.errors = {};

      if (!this.form.name.trim()) {
        this.errors.name = 'Name is required';
      }

      if (!this.form.email.trim()) {
        this.errors.email = 'Email is required';
      } else if (!/\S+@\S+\.\S+/.test(this.form.email)) {
        this.errors.email = 'Please enter a valid email';
      }

      return Object.keys(this.errors).length === 0;
    },

    async submitForm() {
      if (!this.validateForm()) return;

      this.isSubmitting = true;

      try {
        // Simulate API call
        await new Promise((resolve) => setTimeout(resolve, 1500));

        this.showAlert('success', 'Form submitted successfully!');
        this.form = { name: '', email: '' };
      } catch (error) {
        this.showAlert('error', 'Something went wrong. Please try again.');
      } finally {
        this.isSubmitting = false;
      }
    },

    showAlert(type, message) {
      this.alertType = type;
      this.alertMessage = message;
      this.showAlert = true;

      // Trigger animation
      this.$nextTick(() => {
        this.isVisible = true;
      });

      // Auto-hide after 5 seconds
      setTimeout(() => {
        this.isVisible = false;
        setTimeout(() => {
          this.showAlert = false;
        }, 200);
      }, 5000);
    },
  },
};
</script>