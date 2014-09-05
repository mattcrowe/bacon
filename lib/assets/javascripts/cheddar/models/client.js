Cheddar.Client = DS.Model.extend({
    name: DS.attr('string'),
    rate: DS.attr('number'),
    contact: DS.attr('string'),
    email: DS.attr('string'),
    address1: DS.attr('string'),
    address2: DS.attr('string'),
    city: DS.attr('string'),
    state: DS.attr('string'),
    zip: DS.attr('string'),
    create_at: DS.attr('date'),
    updated_at: DS.attr('date')
});

Cheddar.Client.reopenClass({
    STATES: ['OH', 'KY', 'NY']
});