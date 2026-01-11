// Client Controller for Custom Service Portal Widget
angular.module('portalApp').controller('CustomServiceCatalogController', 
    function($scope, spUtil, $location) {
        var c = this;
        
        c.categories = [];
        c.selectedCategory = null;
        c.catalogItems = [];
        
        c.init = function() {
            c.loadCategories();
        };
        
        c.loadCategories = function() {
            spUtil.get('custom_service_catalog', {action: 'getCategories'})
                .then(function(response) {
                    c.categories = response.data.categories;
                });
        };
        
        c.selectCategory = function(category) {
            c.selectedCategory = category;
            spUtil.get('custom_service_catalog', {
                action: 'getCatalogItems',
                category: category.sys_id
            }).then(function(response) {
                c.catalogItems = response.data.items;
            });
        };
        
        c.requestItem = function(item) {
            var url = '/sp?id=sc_cat_item&sys_id=' + item.sys_id;
            $location.url(url);
        };
        
        c.init();
    });

// Server Script for Widget Data Provider
(function() {
    var action = input.action || 'getCategories';
    
    if (action == 'getCategories') {
        var categoryGr = new GlideRecord('sc_category');
        categoryGr.addQuery('active', true);
        categoryGr.addQuery('parent', 'NULL');
        categoryGr.orderBy('title');
        categoryGr.query();
        
        var categories = [];
        while (categoryGr.next()) {
            categories.push({
                sys_id: categoryGr.getUniqueValue(),
                title: categoryGr.getValue('title'),
                description: categoryGr.getValue('description'),
                icon: categoryGr.getValue('icon')
            });
        }
        data.categories = categories;
    }
    
    else if (action == 'getCatalogItems') {
        var itemGr = new GlideRecord('sc_cat_item');
        itemGr.addQuery('active', true);
        itemGr.addQuery('category', input.category);
        itemGr.orderBy('order');
        itemGr.query();
        
        var items = [];
        while (itemGr.next()) {
            items.push({
                sys_id: itemGr.getUniqueValue(),
                name: itemGr.getValue('name'),
                short_description: itemGr.getValue('short_description'),
                price: itemGr.getValue('price'),
                picture: itemGr.getValue('picture')
            });
        }
        data.items = items;
    }
})();