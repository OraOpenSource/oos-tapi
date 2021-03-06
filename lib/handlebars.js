//Overloaded Handlebars

Handlebars = require('handlebars'),


Handlebars.registerHelper('toUpperCase', function(str) {
  return str.toUpperCase();
});

Handlebars.registerHelper('toLowerCase', function(str) {
  return str.toLowerCase();
});

Handlebars.registerHelper('lineBreakToBr', function(str) {
  return str.replace(/\n/g,'<br />');
});

Handlebars.registerHelper('lineBreak', function() {
  return '\n';
});


Handlebars.registerHelper('javaDocParams', function(columns, padding) {
  var str = '';

  columns.forEach(function(val, i){
    str += `${' '.repeat(padding)}* @param p_${val.column_name.toLowerCase()}: ${columns.length === i+1 ? '' : '\n'}`
  });
  return str;
});




Handlebars.registerHelper('initCap', function(str) {
  if (str) {
    return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
  }
  else{
    return str;
  }
});

// From http://stackoverflow.com/questions/8853396/logical-operator-in-a-handlebars-js-if-conditional
Handlebars.registerHelper('ifCond', function (v1, operator, v2, options) {
  switch (operator) {
    case '==':
      return (v1 == v2) ? options.fn(this) : options.inverse(this);
    case '===':
      return (v1 === v2) ? options.fn(this) : options.inverse(this);
    case '<':
      return (v1 < v2) ? options.fn(this) : options.inverse(this);
    case '<=':
      return (v1 <= v2) ? options.fn(this) : options.inverse(this);
    case '>':
      return (v1 > v2) ? options.fn(this) : options.inverse(this);
    case '>=':
      return (v1 >= v2) ? options.fn(this) : options.inverse(this);
    case '&&':
      return (v1 && v2) ? options.fn(this) : options.inverse(this);
    case '||':
      return (v1 || v2) ? options.fn(this) : options.inverse(this);
    case '!=':
      return (v1 != v2) ? options.fn(this) : options.inverse(this);
    case '!==':
      return (v1 !== v2) ? options.fn(this) : options.inverse(this);
    default:
      return options.inverse(this);
  }
});


// TODO mdsouza: create functions for getTypes, getMethods, getConstants
// TODO mdsouza: delete
Handlebars.registerHelper('entityFilter', function(entityType, options) {
  var
    retEntities = []
  ;

  console.log(entityType);

  options.data.root.entities.forEach(function(entity){
    if (entity.type === 'typesBAD'){
      retEntities.push(entity);
    }
  });//entities.forEach

  console.log(retEntities);

  return options.fn(retEntities);
});


module.exports = Handlebars;
