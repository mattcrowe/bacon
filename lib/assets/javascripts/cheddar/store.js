Cheddar.Store = DS.Store.extend({});
Cheddar.ApplicationAdapter = DS.ActiveModelAdapter.extend({});

DS.RESTAdapter.reopen({
    namespace: 'api/v1'
});