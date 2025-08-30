# Prohibited Modules and Practices

This file documents modules, libraries, and coding practices that are prohibited due to security vulnerabilities, performance issues, or maintenance concerns.

## Prohibited Libraries & Modules

### Security Vulnerabilities

#### JavaScript/TypeScript
- **event-stream** (versions with malicious code)
- **lodash** < 4.17.19 (prototype pollution)
- **minimist** < 1.2.2 (prototype pollution)
- **node-uuid** (deprecated, use uuid instead)
- **request** (deprecated, use axios or fetch)

#### Python
- **pickle** for untrusted data (code execution risk)
- **eval()** and **exec()** with user input
- **django** < 3.2 (security vulnerabilities)
- **flask** < 1.1.4 (security issues)
- **pycrypto** (abandoned, use cryptography library)

#### PHP
- **mcrypt** (deprecated and insecure)
- **md5()** for password hashing (use password_hash())
- **mysql_*** functions (use PDO or mysqli)
- **serialize()/unserialize()** with untrusted data
- **eval()** with user input

#### Java
- **log4j** < 2.17.0 (Log4Shell vulnerability)
- **commons-collections** < 3.2.2 (deserialization vulnerabilities)
- **struts2** with known vulnerabilities
- **Jackson** < 2.12.6 (deserialization issues)

#### C#/.NET
- **Newtonsoft.Json** < 12.0.2 (deserialization vulnerabilities)
- **System.Web.Mvc** < 5.2.7 (XSS vulnerabilities)
- **IdentityServer3** (end of life, use IdentityServer4+)

#### C/C++
- **gets()** function (buffer overflow risk)
- **strcpy()** without length checking
- **sprintf()** without length checking
- **system()** with user input

### Performance Issues

#### General
- **Synchronous I/O** in async contexts
- **Blocking operations** in event loops
- **N+1 query patterns** in ORMs
- **Large bundle sizes** without code splitting

#### JavaScript
- **jQuery** for new projects (prefer vanilla JS or modern frameworks)
- **Moment.js** (large bundle size, use date-fns or Day.js)
- **Underscore.js** (use Lodash or native methods)

#### Python
- **Pandas** for simple data operations (overhead)
- **Django ORM** without select_related/prefetch_related
- **Global interpreter lock** intensive operations

#### Database
- **SELECT \*** in production queries
- **Unindexed queries** on large tables
- **Cartesian joins** without proper conditions
- **Recursive queries** without limits

### Maintenance Concerns

#### Abandoned Projects
- **Bower** (package manager, use npm/yarn)
- **Grunt** (task runner, use webpack/Vite)
- **PhantomJS** (headless browser, use Puppeteer)
- **Internet Explorer** specific code

#### Deprecated Features
- **Flash** and related technologies
- **Java Applets** in web browsers
- **ActiveX** controls
- **Silverlight** applications

## Prohibited Coding Practices

### Security Anti-Patterns
- **SQL injection** vulnerable code
- **XSS** vulnerable output without escaping
- **CSRF** without proper token validation
- **Hardcoded credentials** in source code
- **Insecure direct object references**
- **Directory traversal** vulnerabilities

### Performance Anti-Patterns
- **String concatenation** in loops (all languages)
- **Database queries** inside loops
- **Synchronous operations** blocking UI
- **Memory leaks** through uncleared references
- **Infinite recursion** without base cases

### Maintainability Anti-Patterns
- **God objects** and classes
- **Spaghetti code** with complex dependencies
- **Magic numbers** without constants
- **Copy-paste programming**
- **Overly complex inheritance** hierarchies

### Language-Specific Prohibitions

#### JavaScript
- **var** declarations (use let/const)
- **== comparison** (use strict === comparison)
- **callback hell** (use Promises/async-await)
- **Global variables** pollution

#### Python
- **bare except** clauses
- **mutable default arguments**
- **import \*** statements
- **global variables** modification

#### PHP
- **register_globals** (if somehow available)
- **magic_quotes** reliance
- **extract()** with user data
- **variable variables** $$var without validation

#### Java
- **finalize()** method overriding
- **clone()** without proper implementation
- **String concatenation** with + in loops
- **Raw types** instead of generics

#### C/C++
- **Manual memory management** where RAII available
- **C-style casts** in C++
- **Multiple inheritance** of implementation
- **Goto statements** in structured code

## Exception Handling

### When Prohibited Items May Be Used
1. **Legacy System Maintenance**: When modification risk exceeds security risk
2. **Gradual Migration**: During controlled migration periods with mitigation
3. **Isolated Environments**: In completely isolated systems with no external access
4. **Research Purposes**: In non-production research environments only

### Mitigation Requirements
- **Documented Risk Assessment**: Written justification and risk analysis
- **Isolation Measures**: Network and system isolation
- **Monitoring**: Enhanced logging and monitoring
- **Time-boxed Usage**: Clear timeline for replacement
- **Approval Process**: Security team approval required

## Reporting Process

### Identifying New Risks
1. **Security Bulletins**: Monitor CVE databases and security advisories
2. **Community Reports**: Track GitHub issues and community discussions
3. **Performance Analysis**: Regular performance profiling and analysis
4. **Maintenance Status**: Monitor project activity and maintainer response

### Update Process
1. **Risk Assessment**: Evaluate severity and impact
2. **Documentation**: Add to blacklist with detailed explanation
3. **Communication**: Notify development teams
4. **Migration Plan**: Provide alternative solutions and migration paths

---

*Last Updated: 2025.08.07-00001*
*Review Schedule: Weekly for security alerts, Monthly for general updates*
