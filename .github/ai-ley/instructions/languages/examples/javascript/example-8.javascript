// ✅ Function composition utilities
const pipe = (...fns) => value => fns.reduce((acc, fn) => fn(acc), value);
const compose = (...fns) => value => fns.reduceRight((acc, fn) => fn(acc), value);

// ✅ Utility functions
const curry = fn => (...args) => {
  if (args.length >= fn.length) {
    return fn(...args);
  }
  return (...nextArgs) => curry(fn)(...args, ...nextArgs);
};

// ✅ Data transformation pipeline
const processUsers = pipe(
  users => users.filter(user => user.isActive),
  users => users.map(user => ({
    ...user,
    fullName: `${user.firstName} ${user.lastName}`
  })),
  users => users.sort((a, b) => a.createdAt - b.createdAt)
);

// ✅ Curried functions for reusability
const filterBy = curry((predicate, array) => array.filter(predicate));
const mapTo = curry((mapper, array) => array.map(mapper));

const activeUsers = filterBy(user => user.isActive);
const userNames = mapTo(user => user.name);

// Usage
const result = pipe(
  activeUsers,
  userNames
)(allUsers);