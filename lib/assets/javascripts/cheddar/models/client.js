Cheddar.Client = DS.Model.extend({
    name: DS.attr(),
    rate: DS.attr(),
    contact: DS.attr(),
    email: DS.attr(),
    address1: DS.attr(),
    address2: DS.attr(),
    city: DS.attr(),
    state: DS.attr(),
    zip: DS.attr(),
    create_at: DS.attr(),
    updated_at: DS.attr()
});