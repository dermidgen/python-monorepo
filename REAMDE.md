# Python Monorepo
This is an example of scaffolding and tooling for a Python based monorepo, with the goal of demonstrating:

 * Microservices & CI/CD compatible
 * Monorepo tooling for handling builds with shared libraries
 * Shared library anti-pattern for microservices; cause why not
 * Non-versioned, service-bound share libraries; alleviate version drift & integration challenges

## Tooling
This example offers tooling that supports a local development paradigm where changes to shared libraries are immediately available when running & testing individual services. This also supports CI/CD flows where changes to any shared library should cause dependent services to rebuild & integration test those changes immediately. Poetry helps makes this possible. Poetry also allows venvs to be local to the service you're working on, making debugging dependencies a breeze.

 * Poetry for local development & dependencies.
 * GNU Make for local builds & cleaning.
 * Bash script for CI/CD builds.
 * Docker for containers.

The most specific challenge this tooling addresses, is how to properly build all the dependencies into a Docker container. Poetry does not really help here. The Makefiles provide a very lightweight and powerful approach to this. This example provides a shell script that does roughly the same thing - but it rebuilds everything _every_ time.  GNU Make gives us some smarts that will help avoid great pains for larger libraries or projects. The shell script offers a tool that is a bit more friendly for CI/CD environments where your build is in a clean environment and will require rebuilding everything anyways.

## Builds
This example demonstrates calculating the dependencies of a service, building wheels for everything, and using wheels to perform a standard pip installation in a container.

Some advantages to this strategy:
 * Lightest possible Docker build context; _only_ needs to see wheels
 * Lightest possible Docker containers; no poetry or other junk in there; no raw sources
 * Simplest Dockerfile definition possible
 * Dependencies are declared only once in a pyproject.toml
 * We don't have to publish packages/modules or deal with private pypi repos
 * Poetry locks guide the building of wheels and dependency resolution - before we build
 * CI/CD can track changes to libs/services and trigger services to rebuild/deploy anytime libs are changed
 * Local .venv means we can very easily clean up to save disk space when we're not working on a service/library
 * You can run concurrent local clean/builds because dependencies are staged in the service dist/deps before building

Disadvantages include:
 * Since we install from wheels shared libraries or services can't do advanced things like compilation of C libs during install; but their dependencies still can.
 * This allows for some bad behavior and tacitly promotes the shared-code anti-pattern when doing microservices.
 * Tooling dependent. At least you can keep the tooling pretty light and easy to understand.
 * Poetry creates a fresh venv for every service. This can lead to a _ton_ of bloat locally.
 * Changes to shared libraries will cause Docker build to reinstall all of their dependencies; keep them light.
