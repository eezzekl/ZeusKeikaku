$(document).ready(function () {
    $('#textarea')
        .textext({
            //plugins: 'tags autocomplete'
            //plugins : 'autocomplete filter tags ajax'
            plugins: 'tags prompt focus filter autocomplete ',
            prompt: 'Agregar Bandas...'
        })
        .bind('getSuggestions', function (e, data) {
            var list = [
                    'Amperion',
                    'akon',
                    'Uberhate',
                    'Vampiros_Leyenda_Urbana',
                    'DWBD',
                    'Matanza'
            ],
                textext = $(e.target).textext()[0],
                query = (data ? data.query : '') || ''
            //query = data.query
            ;

            $(this).trigger(
                'setSuggestions',
                { result: textext.itemManager().filter(list, query) }
            );
        })
    ;
});