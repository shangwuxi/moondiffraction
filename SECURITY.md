# Security and reliability scope

The library does not access files, the network, process shells or experimental equipment. All loops accepting variable-size numerical work have finite caps. Untrusted callers must handle typed Invalid/Budget errors and must not treat the library as a metrology or safety decision system. Mutable exported arrays can be modified by callers; post-mutation outputs no longer carry original computation meaning.

Report reproducible numerical failures or resource-limit bypasses in repository issues, without uploading sensitive experimental data or credentials. There is no claim of a private security reporting channel or response SLA.
