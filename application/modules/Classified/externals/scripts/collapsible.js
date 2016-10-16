
window.addEvent('domready', function() {
   $$('.classifieds-category-sub-category').set('styles', {
        display : 'none'
    });
    
     $$('.classifieds-category-collapse-control').addEvent('click', function(event) {

        var row = this.getParent('li');

        if (this.hasClass('classifieds-category-collapsed')) {

        	var id = row.getAttribute('value');
        	var rowSubCategories = row.getAllNext('li.child_'+id);  

            this.removeClass('classifieds-category-collapsed');
            this.addClass('classifieds-category-no-collapsed');

            for(var i = 0; i < rowSubCategories.length; i++) {

                if (!rowSubCategories[i].hasClass('classifieds-category-sub-category')) {
                    break;
                } else {
                    rowSubCategories[i].set('styles', {
                        display : 'block'
                    });
                }
            }

        } else {

        	var rowSubCategories = row.getAllNext('li');

            this.removeClass('classifieds-category-no-collapsed');
            this.addClass('classifieds-category-collapsed');

            for(var i = 0; i < rowSubCategories.length; i++) {

                if (!rowSubCategories[i].hasClass('classifieds-category-sub-category')) {
                    break;
                } else {
                	var collapsedDivs = rowSubCategories[i].getElements('.classifieds-category-collapse-control');

                	if (collapsedDivs.length > 0) {
                		collapsedDivs[0].removeClass('classifieds-category-no-collapsed');
                		collapsedDivs[0].addClass('classifieds-category-collapsed');
                	}

                    rowSubCategories[i].set('styles', {
                        display : 'none'
                    });
                }
            }
        }
    }); 
});