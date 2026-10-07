# Repository rules

The Conventional Commits specification is a lightweight convention on top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier to write automated tools on top of.
Describing the features, fixes, and breaking changes made in commit messages.
[link to official page](https://www.conventionalcommits.org/en/v1.0.0/)

## Commit message structure

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Specification

1. Commits must be prefixed with a type, which consists of a noun (`feat`, `fix`, etc.), an optional scope, an optional `!`, and a required terminal colon and space.
2. The type `feat` MUST be used when a commit adds a new feature to your application or library.
3. The type `fix` MUST be used when a commit represents a bug fix for your application.
4. A scope MAY be provided after a type. A scope MUST consist of a noun describing a section of the codebase surrounded by parenthesis, e.g., `fix(parser):`.
5. A description MUST immediately follow the colon and space after the type/scope prefix. The description is a short summary of the code changes.
6. A longer commit body MAY be provided after the short description, providing additional contextual information about the code changes. The body MUST begin one blank line after the description.
7. A commit body is free-form and MAY consist of any number of newline separated paragraphs.
8. One or more footers MAY be provided one blank line after the body. Each footer MUST consist of a word token, followed by either a `:<space>` or `<space>#` separator, followed by a string value.
9. A footer's token MUST use `-` in place of whitespace characters, e.g., `Acked-by` (this helps differentiate the footer section from a multi-paragraph body). An exception is made for `BREAKING CHANGE`, which MAY also be used as a token.
10. A footer's value MAY contain spaces and newlines, and parsing MUST terminate when the next valid footer token/separator pair is observed.
11. Breaking changes MUST be indicated in the type/scope prefix of a commit, or as an entry in the footer.
12. If included as a footer, a breaking change MUST consist of the uppercase text `BREAKING CHANGE`, followed by a colon, space, and description, e.g., `BREAKING CHANGE: environment variables now take precedence over config files.`
13. If included in the type/scope prefix, breaking changes MUST be indicated by a `!` immediately before the `:`. If `!` is used, `BREAKING CHANGE:` MAY be omitted from the footer section, and the commit description SHALL be used to describe the breaking change.
14. Types other than `feat` and `fix` MAY be used in your commit messages, e.g., `docs:`, `style:`, `refactor:`, `test:`, `build:`, `ci:`, `chore:`.
15. The units of information that make up Conventional Commits MUST NOT be treated as case sensitive by implementors, with the exception of `BREAKING CHANGE`, which MUST be uppercase.
16. `BREAKING-CHANGE` MUST be synonymous with `BREAKING CHANGE`, when used as a token in a footer.

## Examples

Commit message with description and breaking change footer:
```
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

Commit message with `!` to draw attention to breaking change:
```
feat!: send an email to the customer when a product is shipped
```

Commit message with scope and `!` to draw attention to breaking change:
```
feat(api)!: send an email to the customer when a product is shipped
```

Commit message with both `!` and `BREAKING CHANGE` footer:
```
feat!: drop support for Node 6

BREAKING CHANGE: use JavaScript features not available in Node 6.
```

Commit message with no body:
```
docs: correct spelling of CHANGELOG
```

Commit message with scope:
```
feat(lang): add Polish language
```

Commit message with multi-paragraph body and multiple footers:
```
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from the latest request.

Remove timeouts which were used to mitigate the racing issue but are
obsolete now.

Reviewed-by: Z
Refs: #123
```

## Why use Conventional Commits

- Automatically generating CHANGELOGs.
- Automatically determining a semantic version bump (based on the types of commits landed).
- Communicating the nature of changes to teammates, the public, and other stakeholders.
- Triggering build and publish processes.
- Making it easier for people to contribute to your projects, by allowing them to explore a more structured commit history.

## FAQ

**How should I deal with commit messages in the initial development phase?**
Treat it like you've already released the product. Even a project in the initial development phase, with commits following the convention, still has usefulness: other contributors and users can gain a clear understanding from the commit history on what's going on; version numbers and released types (fix, feature, breaking change) are relevant to projects no matter what stage of development.

**Are the types in the commit title uppercase or lowercase?**
Any casing may be used, but it's best to be consistent.

**What do I do if the commit conforms to more than one of the commit types?**
Go back and make multiple commits whenever possible. Part of the benefit of Conventional Commits is its ability to drive us to make more organized commits and PRs.

**Doesn't this discourage rapid development and fast iteration?**
It discourages moving fast in a disorganized way. It helps you be able to move fast long term across multiple projects with varied contributors.

**Might Conventional Commits lead people to limit the type of commits they make, because they'll be thinking in the box of the existing types?**
Conventional Commits encourages making more of certain types of commits, such as fixes. Other than that, the flexibility of Conventional Commits allows your team to come up with their own types and change those types over time.

**How does this relate to SemVer?**
`fix` type commits should be translated to `PATCH` releases. `feat` type commits should be translated to `MINOR` releases. Commits with `BREAKING CHANGE` in the commits, regardless of type, should be translated to `MAJOR` releases.

**How should I version my extensions to the Conventional Commits Specification, e.g., `@jameswomack/conventional-commit-spec`?**
Use SemVer to communicate to your consumers and contributors of your extension about breaking changes, new features, or patches.

**What do I do if I accidentally use the wrong commit type?**
When using a type that's not in the specification, such as `feat(lol)`, if it's still compliant with the specification, correct the structure prior to merge/release. If not compliant, it's a non-issue: the commit will simply be ignored by tools that key off of the spec.

**Do all the contributors need to use the Conventional Commits specification?**
No. If you use a squash-based Git workflow, lead maintainers can clean up the commit messages as they're merged, without impacting the original commit authors.

**How does Conventional Commits handle revert commits?**
Revert commits should be clearly identified as a revert of a previous commit — e.g., by using the type `revert` and a reference to the SHA being reverted:
```
revert: let us never again speak of the noodle incident

Refs: 676104e, a215868
```

---

Fuente completa: [conventionalcommits.org/en/v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
