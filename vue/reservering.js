var app = new Vue({
    el: '#app',
    data: {
        errorMsg: "",
        successMsg: "",
        showAddModal: false,
        showEditModal: false,
        showDeleteModal: false,
        reserveringen: [],
        newReservering: { Tafel: "", Datum: "", Tijd: "", Klant_ID: "", Aantal: "", Status: "", Datum_toegevoegd: "", Aantal_k: "", Allergieen: "", Opmerkingen: ""},
        currentReservering: {}
    },
    mounted: function () {
        this.getAllProducts();
    },
    methods: {
        getAllProducts() {
            axios.get("http://localhost/vue/reservering.php?action=read").then(function (response) {
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.reserveringen = response.data.reserveringen;
                }
            });
        },
        addProduct() {
            var formData = app.toFormData(app.newReservering);
            axios.post("http://localhost/vue/reservering.php?action=create", formData).then(function (response) {
                app.newReservering = newReservering;
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                }
            });
        },

        updateProduct() {
            var formData = app.toFormData(app.currentReservering);
            axios.post("http://localhost/vue/reservering.php?action=update", formData).then(function (response) {
                app.currentReservering = {};
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                    console.log(app.currentReservering);
                }
            });
        },

        deleteProduct() {
            var formData = app.toFormData(app.currentReservering);
            axios.post("http://localhost/vue/reservering.php?action=delete", formData).then(function (response) {
                app.currentReservering = {};
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
        selectReserveringen(reserveringen){
           app.currentReservering= reserveringen;
        },
        clearMsg() {
            app.errorMsg = "";
            app.successMsg = ""; 
        }
     }
    
});