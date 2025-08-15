# Helm : 

is managing packages for kubernetes use format call *charts*.

**charts**: A chart is a collection of files that describe a related set of Kube resources.A single charts might ne used to deploy something simple, like a memcached pod, or something complex, like a full web app stacj with HTTP servers, databases, caches, and so on.

charts are created as files laid out in a particular directory tree. They can be packaged inte versioned archives to be deployed.


>mychart/
> - Chart.yaml
> - values.yaml
> - charts/
> - templates/
>...

If you want to download and look at the files for a published chart, without installing it, you can do so with :

>helm pull chartrepo/chartname

This document explains the chart format and provides basic guidance for building charts with Helm.

# A Starter Chart
> $ helm create mychart

The tuto tell us to erase everthing from chart/templates
> rm -fr mychart/templates/*

