var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {
    var cardsTemplate,locationFilterTemplate,companyDetailsTemplate,citiesAndDepartmentTemplate;
    var cities ;//,{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},,{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false}];
    var departments ; //= [{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false}];//,{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false}];
    var limit,offset;

    var compileHandlebarTemplate = function(templateId) {
        var source   = $('#' + templateId).html();
        return Handlebars.compile(source);
    };

    var compileTemplate = function(){
        cardsTemplate = compileHandlebarTemplate("cards-template");
        // companyDetailsTemplate = compileHandlebarTemplate("company-details-template");
        citiesAndDepartmentTemplate = compileHandlebarTemplate('cities-department-filter-template');
        console.log(citiesAndDepartmentTemplate);
    };
    
    var handlebarUpdateDom = function(domId,template,json) {
        var html = template(json);
        $('#' + domId).html(html);
    };

    var filterCities = function() {
        handlebarUpdateDom("filter_cities",citiesAndDepartmentTemplate,cities);
    };

    var filterDepartment = function () {
        handlebarUpdateDom("filter_department",citiesAndDepartmentTemplate,departments);
    };

    var generateFilterHandlebar = function (id,data) {
        handlebarUpdateDom(id,citiesAndDepartmentTemplate,data);
    };

    var loadCities = function(){
        $.ajax({
            url: "/dashboard/cities",
            type: "GET",
            async: false,
            success: function(response){
                cities = response.data;
            },
            error: function(xhr,status,error){
                cities = [];
                console.log("cities api exception!.");
            }
        })
    }


    var loadDepartments = function(){
        $.ajax({
            url: "/dashboard/departments",
            type: "GET",
            async: false,
            success: function(response){
                departments = response.data;
            },
            error: function(xhr,status,error){
                departments = [];
                console.log("departments api exception!.");
            }
        })
    }

    var setSortingDropdown = function(){
        var sort_option = getUrlParameter("sort_option");
        $(".ui.dropdown").dropdown("set selected",sort_option);
    };
    var setSearchBar = function(){
        var search_query = getUrlParameter("q");
        $(".prompt.search-bar").val(search_query);
    };

    var setfilterOnRefresh = function(){
        var params = decodeURI(location.search.substring(1));
        params = params.split("&");
        for(var i=0;i<params.length;i++){
            var key_value = params[i].split("=");
            if( key_value[0] == "l[]"){
                $('#filter_cities .ui.checkbox input[name="'+key_value[1]+'"]').parent().checkbox('set checked');
            }
            if(key_value[0] == "d[]"){
                $('#filter_department .ui.checkbox input[name="'+key_value[1]+'"]').parent().checkbox('set checked');
            }
        }

    };

    var cards = function(sort_option){
        var params = window.location.search.substring(0);
        var uri = "/dashboard/search_college_drives"+params;
        $.ajax({url:uri,
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
                // setSortingDropdown();
                // setSearchBar();
                // setfilterOnRefresh();
                // TODO
                // registerCardsScrollBottom();
            },
            error: function(xhr,status,error){
                console.log(error);
            }
        });
    };



    var init =function(){
        $().ready(function() {
            console.log("CampusConnect.Dashboard.init");
            loadCities();
            loadDepartments();
            compileTemplate();
            filterCities();
            filterDepartment();
            $(".ui.checkbox").change(function(){
                // TODO
              // addFilter();
            });
            $('.sort.ui.dropdown').dropdown({
              onChange: function(value, text, $selectedItem) {
                // TODO
                // sorted_cards(value);
              }
            });
            $(".prompt.search-bar").keydown(function(event){
              if (event.keyCode == 13) {
                  var query = $(this).val();
                  // TODO
                  // search_openings(query);
              }
            });
            cards();
        });
    };

    return {
    	init:init
    };
}();

