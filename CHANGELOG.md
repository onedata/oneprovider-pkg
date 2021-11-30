Release notes for project oneprovider-pkg
=========================================

CHANGELOG
---------

### 21.02.0-alpha23

-   **VFS-8653** Web GUI: added \"follow symbolic links\" option in
    create archive options.
-   **VFS-8518** Web GUI: unlocked possibility to create a hardlink for
    symlink.
-   **VFS-8478** Preserved archives are now protected from any
    modifications. Before archive is marked as preserved its content is
    verified to ensure that no modifications have been made during its
    creation.
-   **VFS-8425** Added basic cookie support to HTTP storage helper to
    support OAuth redirect authorization.
-   **VFS-8405** Web GUI: fixed QoS modal errors when a hardlink for
    viewed file with QoS requirements has been deleted.
-   **VFS-8404** Failed lanes are now retried up to specified max
    retries (given in schema definition).
-   **VFS-8348** Web GUI: added links to transferred files on transfers
    view and information about their membership in archive and dataset.
-   **VFS-8318** Fixed conda packaging for oneclient and onedatafs,
    switched dependencies to conda-forge channel.
-   **VFS-8288** It is now possible to specify requested resources and
    resource limits on the lambda and task level for OpenFaaS functions.
-   **VFS-8281** Improved file upload mechanisms to better handle
    clients with very slow network connections.
-   **VFS-8250** Exceptions returned from user defined lambda OpenFaaS
    functions are now properly handled and saved to lane exception
    store.
-   **VFS-8247** Added new option to harverster\'s indices that allow
    for harvesting details about archives (archiveId, archiveDescription
    and archiveCreationTime).
-   **VFS-8242** Upgraded Oneclient to use Fuse 3 by default.
-   **VFS-8240** Applied fixes suggested by new version of clang-tidy
    static C++ code analyzer.
-   **VFS-8237** Updated C++ clang-format version to 12.
-   **VFS-8225** Lanes are now created right before their execution
    rather than alltogether at the start of workflow execution.
-   **VFS-8172** Add \`/health\` endpoints to REST APIs of all services.
-   **VFS-8073** Upgrade folly, wangle and proxygen libraries to version
    2021.01.04.00.
-   **VFS-8041** Added basic log entries to workflow execution and task
    execution audit logs.
-   **VFS-7960** Fixed navigating through multiple spaces during files
    upload in GUI.
-   **VFS-7930** Web GUI: improved UX of creating incremental archives
    using archive context menu.
-   **VFS-7898** Web GUI: added self-shortening links to files with
    support for files inside archives.
-   **VFS-7779** Added REST API for CRUD operations on file using
    relative paths.
-   **VFS-7728** Introduced versioning of lambdas and workflow schemas.
    Users may create subsequent revisions of the above models and modify
    their statuses (draft, stable, deprecated) to simplify management
    and retain backward compatibility of definitions that are already in
    use.
-   **VFS-7664** It is now possible to configure symbolic links policy
    when creating an archive. By default symbolic links in dataset are
    resolved resulting in link target being archived.
-   **VFS-7633** UX improvements in web GUI concerning navigation
    between files, datasets and archives using hyperlinks.
-   **VFS-7629** Web GUI: added new datasets panel with archives browser
    in file browser.
-   **VFS-7512** Web GUI: redesigned file tags with information about
    inherited QoS and datasets properties.

