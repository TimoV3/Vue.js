var app = new Vue({
    el: '#app',
    data: {
        errorMsg: "",
        successMsg: "",
        showAddModal: false,
        showEditModal: false,
        showDeleteModal: false,
        menuitems: [],
        newMenuitem: {  Code: "", Naam: "", Gerechtsoort_ID: ""},
        currentMenuitem: {}
    },
    mounted: function () {
        this.getAllProducts();
    },
    methods: {
        getAllProducts() {
            axios.get("http://localhost/vue/dranken.php?action=read").then(function (response) {
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.menuitems = response.data.menuitems;
                }
            });
        },
        addProduct() {
            var formData = app.toFormData(app.newMenuitem);
            axios.post("http://localhost/vue/dranken.php?action=create", formData).then(function (response) {
                app.newMenuitem = newMenuitem;
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                }
            });
        },

        updateProduct() {
            var formData = app.toFormData(app.currentMenuitem);
            axios.post("http://localhost/vue/dranken.php?action=update", formData).then(function (response) {
                app.currentMenuitem = {};
                if (response.data.error) {
                    app.errorMsg = response.data.message;
                } else {
                    app.successMsg = response.data.message;
                    app.getAllProducts();
                    console.log(app.currentMenuitem);
                }
            });
        },

        deleteProduct() {
            var formData = app.toFormData(app.currentMenuitem);
            axios.post("http://localhost/vue/dranken.php?action=delete", formData).then(function (response) {
                app.currentMenuitem = {};
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
        selectMenuitems(menuitems){
           app.currentMenuitem= menuitems;
        },
        clearMsg() {
            app.errorMsg = "";
            app.successMsg = ""; 
        }
     }
    
});