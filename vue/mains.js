var app = new Vue({
    el: '#app',
    data: {
        errorMsg: "",
        successMsg: "",
        showAddModal: false,
        showEditModal: false,
        showDeleteModal: false,
        shop: [],
        newShop: { merk: "", beschrijving: "", product: ""},
        currentShop: {}
    },
    mounted: function () {
        this.getAllProducts();
    },
    methods: {
        getAllProducts() {
            axios.get("http://localhost/vue/proces.php?action=read").then(function (response) {
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.shop = response.data.shop;
                }
            });
        },
        addProduct() {
            var formData = app.toFormData(app.newShop);
            axios.post("http://localhost/vue/proces.php?action=create", formData).then(function (response) {
                app.newShop = newShop;
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                }
            });
        },

        updateProduct() {
            var formData = app.toFormData(app.currentShop);
            axios.post("http://localhost/vue/proces.php?action=update", formData).then(function (response) {
                app.currentShop = {};
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                }
            });
        },

        deleteProduct() {
            var formData = app.toFormData(app.currentShop);
            axios.post("http://localhost/vue/proces.php?action=delete", formData).then(function (response) {
                app.currentShop = {};
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                }
            });
        },

        toFormData(obj){
            var fd = new FormData();
            for(var i in obj){
                fd.append(i, obj[i]);
            }
            return fd;
        },
        selectShop(shop){
           app.currentShop= shop;
        },
        clearMsg() {
            app.errorMsg = "";
            app.successMsg = ""; 
        }
     }
    
});