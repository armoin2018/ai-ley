// Custom validation rules
function validateNamingConventions(model) {
  model.elements.forEach((element) => {
    if (!element.name.match(/^[A-Z][a-zA-Z\s]+$/)) {
      console.warn(`Invalid name: ${element.name}`);
    }
  });
}

function validateRelationships(model) {
  model.relationships.forEach((rel) => {
    if (!isValidRelationship(rel.source.type, rel.target.type, rel.type)) {
      console.error(`Invalid relationship: ${rel.type}`);
    }
  });
}