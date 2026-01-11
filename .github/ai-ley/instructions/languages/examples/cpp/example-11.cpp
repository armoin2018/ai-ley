// .clang-tidy configuration
Checks: >
    *,
    -fuchsia-*,
    -google-*,
    -zircon-*,
    -abseil-*,
    -llvm-*,
    -android-*,
    -altera-*,
    -cert-err58-cpp,
    -misc-non-private-member-variables-in-classes,
    -readability-identifier-length

WarningsAsErrors: '*'
HeaderFilterRegex: '.*'
AnalyzeTemporaryDtors: false

CheckOptions:
  - key: readability-identifier-naming.NamespaceCase
    value: lower_case
  - key: readability-identifier-naming.ClassCase  
    value: CamelCase
  - key: readability-identifier-naming.FunctionCase
    value: lower_case
  - key: readability-identifier-naming.VariableCase
    value: lower_case
  - key: readability-identifier-naming.ConstantCase
    value: UPPER_CASE