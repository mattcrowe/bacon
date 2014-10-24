Ember.Handlebars.registerBoundHelper('currentDate', function() {
    return moment().format('LL');
});

Ember.Handlebars.registerBoundHelper('date', function(datetime, format) {
    if (!format.length) {
        format = 'LL';
    }
    return moment(datetime).format(format);
});