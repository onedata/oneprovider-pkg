# Release notes for project oneprovider-pkg

## CHANGELOG

### 21.02.7

-   **VFS-12295** Web GUI: Fixed issues with opening share views without
    some privileges and when filea had been deleted.
-   **VFS-12284** Web GUI: Improved GUI for Europeana Data Model:
    updated metadata specification, added more validators, improved UX.
-   **VFS-12080** Web GUI: Added support for creating custom login view
    pages.
-   **VFS-12050** Web GUI: Added support for customizable extended
    attributes (xattrs) columns in file browser.

### 21.02.6

-   **VFS-12239** Web GUI: Automatically filling-in the EDM file size
    property on metadata creation and modification.
-   **VFS-12232** Web GUI: Improved UX of Europeana Data Model editor.
-   **VFS-12198** Web GUI: Added public download URL to file details
    panel for shared files.
-   **VFS-12197** Web GUI: Improved share list views.
-   **VFS-12195** The name of the handle service where an Open Data
    handle has been registered is now publicly visible and always
    displayed on the Share view.
-   **VFS-12110** Added a circuit breaker mechanism that disables all
    Onezone services when the database is close to running out of disk
    space.
-   **VFS-12060** Storage backends are now monitored and when failure is
    detected access to the supported spaces is blocked.
-   **VFS-12052** Web GUI: Removed skipStorageDetection option.
-   **VFS-12049** Web GUI: Added File ID column in file browser.
-   **VFS-12012** Web GUI: Added Permissions column in file browser.
-   **VFS-12001** Web GUI: Added available users list inferring in the
    ACL view entity selector when user lacks some privileges in the
    space.
-   **VFS-11948** Web GUI: Added Creation time and Access time columns
    in file browser.

### 21.02.5

-   **VFS-11999** Improved listing objects on S3 storages during data
    import.
-   **VFS-11979** Web GUI: Fixed ACL editor view crash when user has no
    space view privilege in the space. It is now possible to choose
    groups that the user belongs to in the ACL editor and as input to
    workflow stores, regardless of the user's privileges in the space.
-   **VFS-11970** Web GUI: Added support for editing already published
    Open Data metadata.
-   **VFS-11945** Automation: Added support for new group data type.
-   **VFS-11923** Web GUI: Renamed privilege group names in the ACL
    editor: "General" to "Deletion" and "Data" to "Content".
-   **VFS-11912** Web GUI: Added visual editor for Open Data metadata in
    Europeana Data Model format.
-   **VFS-11904** Implemented storage specific health check, to check
    and monitor storage availability.
-   **VFS-11876** Allow rtransfer storage parameters change without the
    need for rtransfer restart.
-   **VFS-11761** Web GUI: Improved user experience in publishing share
    as Open Data.
-   **VFS-11744** Web GUI: Refactored UX of changing provider settings
    in cluster.
-   **VFS-11731** Web GUI: Fixed unexpected scroll down of file list
    after closing file details panel.
-   **VFS-11726** Web GUI: Fixed items selection in archives browser
    after using breadcrumbs menu.
-   **VFS-11712** Integration of Onedata and the Galaxy project; added a
    driver to Galaxy enabling the use of Onedata as a so-called "Object
    Store" --- this way, datasets in Galaxy can be stored in a Onedata
    space.
-   **VFS-11710** Web GUI: added possibility to embed Onedata Web
    application into an iframe hosted on site with domain other than
    Onezone.
-   **VFS-11707** Web GUI: Detecting web browser extensions potentially
    interfering with Onedata GUI.
-   **VFS-11625** Extended functionality of runtime storage parameter
    updates to all storage backends.
-   **VFS-11607** Web GUI: Improvements of the ACL editor in the file
    browser: detection of ACL rules forbidding permissions modification,
    better descriptions and hints about settings, and numerous minor
    User Experience tweaks.
-   **VFS-11595** Web GUI: Fixed missing application elements when Qwant
    VIPrivacy add-on is installed in user's browser.
-   **VFS-11594** Web GUI: Fixed QoS query builder "Add" button
    out-of-the-screen placement.
-   **VFS-11566** Web GUI: Fixed issues with show/download link to space
    root directory.
-   **VFS-11536** Web GUI: Added "Changed (metadata)" (ctime) column to
    the file list.
-   **VFS-11487** Web GUI: Added QoS and Replication columns to the file
    list. Reworked the file attribute fetching mechanisms to fetch only
    the required attributes.
-   **VFS-11443** Automation: Added support for resolving only subset of
    selected file attributes for lambda invocation.
-   **VFS-11365** Improvements to Open Data publishing and the OAI-PMH
    protocol implementation. Added support for Europeana Data Model
    metadata type. Improved the metadata editor in UI (both the visual
    and XML forms). Improved the conformity to OAI-PMH protocol spec and
    added support for optional functionalities. Added an HTTPS endpoint
    (next to previously supported HTTP).
-   **VFS-11080** Web GUI: Fixed share disappearing from the list after
    delete failure.
-   **VFS-10910** Reworked REST API endpoints used to retrieve file
    attributes (get attributes, list, list recursively). Options are now
    accepted as JSON body rather than in query string, some attributes
    were renamed, and the list of available ones has been extended. The
    old behaviour was retained as deprecated and scheduled for
    discontinuation in the future major release.
-   **VFS-10265** Changes to user spaces (changing space name,
    joining/leaving a space) are now reflected in Oneclient in real
    time. Added support for spaces with the same name in Oneclient - in
    case of an ambiguity a space name is extended with its ID.
-   **VFS-9157** Web GUI: Added support for advanced file info in file
    selector panel.
-   **VFS-8554** Web GUI: Fixed uploading files to wrong directory after
    changing directory via URL.

### 21.02.4

-   **VFS-11601** Web GUI: Fixed showing ACL when a subject user or
    group has been removed from space members list.
-   **VFS-11513** Web GUI: Fixed rare issue when file browser list was
    not refreshed after deleting files.
-   **VFS-11459** Added option to set custom region in S3 storage
    helper.
-   **VFS-11405** Web GUI: Added columns drag&drop to change their order
    in transfers table.
-   **VFS-11402** Refactored OneS3 packaging so that ones3 has a
    separate package from oneclient.
-   **VFS-11366** Improvements to directory size statistics; hard link
    sizes are now counted without duplicates toward virtual size (as
    opposed to logical size), archives are counted toward the space data
    size and presented in the UI.
-   **VFS-11282** Added possibility to download automation store's
    content as a JSON file.
-   **VFS-11268** Web GUI: Fixed a rare file list crash when the list is
    being refreshed simultaneously with deleting files.
-   **VFS-11242** Web GUI: added showing separate directory size
    statistics of archives and directories in the space root.
-   **VFS-11210** Fixed a bug with S3 storage backend config
    modification, causing wrong validation of the endpoint.
-   **VFS-11125** Web GUI: Added columns drag&drop to change their order
    in file, dataset and archive browser.
-   **VFS-10999** Added the public "infer access token scope" endpoint,
    which analyses the provided access token to infer the scope of data
    access the token can be used for.
-   **VFS-10649** Web GUI: added complex charts dashboard editor to the
    automation GUI.

### 21.02.3

-   **VFS-11231** Refactored oneclient connection pool to improve
    stability.
-   **VFS-11220** Fixed handling of handshake error in oneclient.
-   **VFS-11106** Refactored Oneclient-Oneprovider connection layer for
    improved resilience to network failures.
-   **VFS-11100** Web GUI: Added support for global URLs to files for
    authenticated users.
-   **VFS-10974** Automation: Added debug logs about items processing.
    They include `traceId` field allowing to correlate them and find
    corresponding items in exception store.
-   **VFS-10962** Web GUI: Improved WebSocket auto-reconnect after
    connection lost (e.g. on system suspend).
-   **VFS-10932** Added possibility to choose logging level during
    workflow execution scheduling.
-   **VFS-10895** Added detailed specification of needed file properties
    in "file" automation type, including narrowing file properties set
    passed to lambda functions during automation workflow exectution.
-   **VFS-10859** Fixed random crash in Oneclient related to events
    streaming.
-   **VFS-10637** Web GUI: Added support for modifying order of columns
    in file, archive and dataset browsers.
-   **VFS-10157** Web GUI: Added ID sufixes to workflow execution names
    to improve readability.
-   **VFS-9052** Web GUI: Improved directory load error handling in file
    browser (eg. no such directory).


### 21.02.2

-   **VFS-10996** Web GUI: Fixed effective protection badges in file
    dataset panel to be updated after ancestor protection change.
-   **VFS-10928** Fixed bug in truncate for object storages with random
    write access, which caused not deleting data above the truncate
    threshold within the last object boundary.
-   **VFS-10875** Web GUI: Improved handling of large amount of spaces
    and storages in Oneprovider panel GUI. Added loading progress
    indicators.
-   **VFS-10825** Web GUI: Fixed unnecessary scrollbars in Safari.
-   **VFS-10824** Web GUI: Fixed file browser crash when entering share
    root using breadcrumbs.
-   **VFS-10803** Web GUI: Fixed polling for file infinitely if moving
    or copying fails.
-   **VFS-10692** Web GUI: Redesigned actions available in various
    context menus of file, dataset and archive browser.
-   **VFS-10612** Add a journal that records the starts and shutdowns of
    services and procedures that help to ensure the graceful stopping of
    services.
-   **VFS-10601** Web GUI: Added columns visibility configuration in
    file browsers.
-   **VFS-10461** Web GUI: Added auto-update of files, datasets and
    archives lists accomplished using polling.
-   **VFS-10411** Web GUI: Added support for incomplete infinite scroll
    listing chunks from backend. It increases stability of file browser
    GUI.

### 21.02.1

-   **VFS-10754** Web GUI: Fixed file list crash after jumping to the
    end and deleting last file.
-   **VFS-10622** Added scalable S3 server interface implementation
    based on Oneclient.
-   **VFS-10546** Removed transfer charts padding when viewing them on
    remote providers.
-   **VFS-10540** Ported rtransfer fixes with better error recovery and
    handling from develop to stable branch 20.02.
-   **VFS-10531** Web GUI: Added support for enum-like data types in
    automation (list of allowed values for string and number types).
-   **VFS-10502** Added option to null device enabling verification of
    whether read data matches written data based on offset and size of
    request, which can be used to test for instance transfer data
    consistency.
-   **VFS-10414** Web GUI: Fixed displaying wrong names of spaces in
    shares sidebar.
-   **VFS-10397** Fixed rtransfer link error propagation issues, which
    sometimes result in hanging transfers.
-   **VFS-10389** Web GUI: Added showing data per provider in directory
    statistics.
-   **VFS-10387** Blocked setting metadata\_protection without
    data\_protection.
-   **VFS-10358** New archive privilege in space - manage archives. It
    is required for modifying other user's archives metadata (like
    description) as well as cancelling them. Those operations can be
    always performed on owned archives (even without this privilege).
    Manage dataset privilege is no longer required for archive
    operations.
-   **VFS-10357** Web GUI: Added support for "manage archives" privilege
    and "creator" information in archives.
-   **VFS-10312** Web GUI: Changed name conflict and disambiguation
    separator from `#` to `@`.
-   **VFS-10283** Web GUI: Added possibility to delete, rename and move
    hardlink to file that is inside data-protected directory and is not
    data-protected itself.
-   **VFS-10264** Added parameter to oneclient handshake protocol to
    distinguish between different oneclient modes of operation.
-   **VFS-10261** Web GUI: Fixed auto-cleaning reports not loading on
    large screens.
-   **VFS-10235** Changed default value of `accountingEnabled` parameter
    to `true` when requesting space support.
-   **VFS-10234** Web GUI: Changed default space support options to have
    directory size statistics aggregation turned on.
-   **VFS-10222** Web GUI: Fixed starting multiple files
    replication/migration/eviction.
-   **VFS-10216** Refactored transfer data source traversal and
    statistics counting so that only regular files would be counted.
-   **VFS-10174** Fixed possible crash in the nulldevice helper when
    simulating large filesystems for importing to data space.
-   **VFS-10149** It is no longer required to have SPACE\_MANAGE\_QOS
    space privilege in order to evaluate QoS expression.
-   **VFS-10134** Improved statistics initialization error handling.
-   **VFS-10129** Web GUI: Added global and per-lane chart dashboards in
    automation workflows.
-   **VFS-10128** Web GUI: Added possibility to map a lambda result to
    many stores in an automation task definition.
-   **VFS-10126** Web GUI: Added Space Marketplace - space
    configuration, spaces browser and membership requests resolver
    views.
-   **VFS-10118** Web GUI: Introduced GUI for automation lambda
    parameters.
-   **VFS-10046** Web GUI: Added user details popovers with user
    information in various views.
-   **VFS-10037** Web GUI: Added "rate" and "timeDerivative" time series
    chart functions.
-   **VFS-9999** Web GUI: Added space details popovers with space
    information in various views.
-   **VFS-9985** Added garbage collector periodically removing old
    automation workflow executions.
-   **VFS-9946** Web GUI: Added filename hashes for distinguishing files
    in audit logs.
-   **VFS-9905** Web GUI: Showing error reason when transfer progress
    cannot be loaded.
-   **VFS-9902** Web GUI: Fixed GUI crash when very long file path is
    shortened.
-   **VFS-9849** Changed stopped status of interrupted automation
    workflow execution with uncorrelated results to `failed` instead of
    `interrupted`.
-   **VFS-9846** Added automation workflow executions graceful stopping
    (pausing all running executions) procedure to Oneprovider stopping
    mechanism.
-   **VFS-9843** Web GUI: Improved UX of action button in file info
    views.
-   **VFS-9801** Web GUI: Added more detailed file counters in transfers
    view.
-   **VFS-9800** Web GUI: Fixed missing owner name in file details and
    added "Owner" column in file browser (on wide screens).
-   **VFS-9795** Web GUI: Fixed user logout from Onezone GUI after
    remove from cluster members.
-   **VFS-9786** Web GUI: Improved UX of file info permissions tab by
    adding hints and disabling modifications when it is not permitted.
-   **VFS-9781** Web GUI: Storage locations are no longer shown in
    shared file info.
-   **VFS-9723** Web GUI: Fixed error message when removing dataset.
-   **VFS-9710** It is now possible to specify that archive should be
    deleted after cancelation.
-   **VFS-9709** Web GUI: Added Open Data tag to items on file list if
    file is published as Open Data.
-   **VFS-9671** Improved monitoring of OpenFaaS cluster health for
    workflow execution purposes.
-   **VFS-9655** Web GUI: Added presentation of directories data
    distribution.
-   **VFS-9637** Web GUI: Improved and unified look of audit log
    browsers.
-   **VFS-9626** Web GUI: Improved UX of file info tabs.
-   **VFS-9622** Upgraded the base image for release dockers from Ubuntu
    18.04 to Ubuntu 20.04.
-   **VFS-9614** Web GUI: Added archivisation audit log view.
-   **VFS-9611** Web GUI: Added showing current directory statistics
    above historical data charts.
-   **VFS-9606** Web GUI: Moved file QoS settings from separate modal to
    file info panel.
-   **VFS-9604** Web GUI: Moved file metadata settings from separate
    modal to file info panel.
-   **VFS-9603** Web GUI: Moved file shares settings from separate modal
    to file info panel.
-   **VFS-9602** Web GUI: Moved file permissions settings from separate
    modal to file info panel.
-   **VFS-9589** Extend time series with information about measurements
    ranges.
-   **VFS-9534** Added Content-Disposition headers to the file download
    REST endpoint.
-   **VFS-9531** Web GUI: Improved UX of the automation stores browser.
-   **VFS-9513** Web GUI: Added file path tooltip to file event in QoS
    audit log.
-   **VFS-9473** Web GUI: Moved file distribution settings from separate
    modal to file info panel.
-   **VFS-9471** Added endpoint for retrievieng regular file location on
    storages.
-   **VFS-9420** Directory statistics and file/directory data
    distribution is now presented in GUI from the point of view of each
    supporting provider.
-   **VFS-9418** Added accountingEnabled and dirStatsServiceEnabled
    settings for space support.
-   **VFS-9342** Added automation task execution Id annotation to
    function registered in OpenFaaS service.
-   **VFS-9339** Web GUI: Added a new file info tab with REST API
    samples.
-   **VFS-9337** Implemented first version of "filePipe" relay method
    for automation lambdas, allowing streaming of results via a file
    located inside the container where the lambda is executed.
-   **VFS-9235** Web GUI: added an input field in file browser for
    scrolling the list to a file or directory using its name prefix.
-   **VFS-9207** Web GUI: Enforced loading fonts from server to avoid
    incorrect local fonts in browser.
-   **VFS-9200** Changed name generation algorithm for functions
    registered in OpenFaaS so that they are unique for each task
    (previously if tasks used the same lambda only one function was
    registered).
-   **VFS-9164** Web GUI: Added support for cancelling archive creation.
-   **VFS-9162** Web GUI: Added API samples modal for space.
-   **VFS-9129** Web GUI: Upgraded EmberJS to v3.8.
-   **VFS-9122** It is now possible to enable directory size and
    capacity statistics collection. Thanks to this, size of directory
    and number of files/directories in subdirectories can be viewed as
    well as how this values change in time.
-   **VFS-9120** Fixed uid/gid encoding to use unsigned int32 rather
    than signed int32, so that it now aligns with POSIX uid\_t and
    gid\_t types.
-   **VFS-9104** It is now possible to list extended attributes along
    with file attributes in REST API.
-   **VFS-9083** Fix typo in NFS storage definition in onepanel REST
    interface definition.
-   **VFS-9054** Improved connection closing in Oneclient.
-   **VFS-9051** Added new files endpoint which allow to list all
    non-directory files (i.e regular files, symbolic links and
    hardlinks) in given top directory recursively. Files are listed
    lexicographically ordered by path.
-   **VFS-9036** Web GUI: Added showing time series charts in executed
    automation workflows.
-   **VFS-9028** Web GUI: added archive properties modal with support
    for changing archive description.
-   **VFS-9026** Added option --message-trace-log to enable logging of
    protobuf messages with the server.
-   **VFS-9023** Web GUI: added "stop recall" feature and improved
    presentation of remote provider recall process.
-   **VFS-9022** It is now possible to cancel ongoing archive recalls.
-   **VFS-9021** Web GUI: added recall error log view.
-   **VFS-9019** Added support for automation time series store.
-   **VFS-8987** Web GUI: Fixed Safari animation glitches.
-   **VFS-8951** Extended directory children listing REST API -
    additional parameter 'attribute' can now be provided to specify one
    or more attributes to be included for each entry. Additionally, when
    there is more entries to be listed, the operation returns a
    'nextPageToken' that can be used to list the subsequent page of
    results.
-   **VFS-8948** Introduced the concept of time series dashboard specs -
    structured recipes for transforming and displaying measurements in
    charts, which can be organized into sections. Each time series
    collection has a linked dashboard spec that will be used for
    rendering the dashboard in GUI.
-   **VFS-8935** Allow enabling statistics collecting for not empty
    spaces.
-   **VFS-8914** Web GUI: redesigned and extended file datasets panel.
-   **VFS-8903** Web GUI: Upgraded EmberJS to v3.4.
-   **VFS-8887** Web GUI: fixed showing file information modal in
    shares.
-   **VFS-8845** Added QoS transfer statistics collection with their
    preview in GUI. Each QoS requirement is associated with several time
    series concerning transferred bytes and files in the context of
    different storages.
-   **VFS-8836** It is now possible to cancel ongoing archivisation.
-   **VFS-8823** Fixed improper destruction of OnedataFS instances,
    resulting in possible deadlocks during deletion of the OnedataFS
    object.
-   **VFS-8817** Added multisupport to NFS helper allowing handling of
    multiple NFS volumes in parallel via a single NFS helper for data
    import.
-   **VFS-8814** Disable NFS direct io in oneclient on conda.
-   **VFS-8788** Added the possibility to handle multiple mountpoints by
    a single POSIX helper in read only mode.
-   **VFS-8783** Web GUI: fixed inability to list files of nested
    archive.
-   **VFS-8739** Web GUI: fixed double listing of dataset items when
    their names have the same prefixes.
-   **VFS-8716** Web GUI: Added complex data types editor to the
    automation views.
-   **VFS-8663** Improved symbolic links resolution behaviour - now, the
    option to resolve symbolic links (e.g. during an archive creation or
    directory download) only applies to symbolic links **pointing to
    paths outside of the dataset/directory**.
-   **VFS-8658** Rename "localceph" storage to "embeded ceph".
-   **VFS-8654** Web GUI: added support for symbolic links in an archive
    pointing outside it.
-   **VFS-8653** Web GUI: added "follow symbolic links" option in create
    archive options.
-   **VFS-8616** Added monitoring of statuses of Kubernetes pods that
    are deployed during workflow execution using the OpenFaaS platform.
    Monitoring is performed by the k8s-events-monitor component and
    reported to the scheduling Oneprovider. Added preview of pod status
    changes in GUI for each workflow task.
-   **VFS-8598** Web GUI: improved presentation of state of archives
    being built and deleted.
-   **VFS-8523** Information about files count and size in directory
    added.
-   **VFS-8518** Web GUI: unlocked possibility to create a hardlink for
    symlink.
-   **VFS-8483** Added direct NFS v3 storage helper.
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
-   **VFS-8247** Added new option to harverster's indices that allow for
    harvesting details about archives (archiveId, archiveDescription and
    archiveCreationTime).
-   **VFS-8242** Upgraded Oneclient to use Fuse 3 by default.
-   **VFS-8240** Applied fixes suggested by new version of clang-tidy
    static C++ code analyzer.
-   **VFS-8237** Updated C++ clang-format version to 12.
-   **VFS-8225** Lanes are now created right before their execution
    rather than alltogether at the start of workflow execution.
-   **VFS-8172** Add `/health` endpoints to REST APIs of all services.
-   **VFS-8073** Upgrade folly, wangle and proxygen libraries to version
    2021.01.04.00.
-   **VFS-8065** Fixed null device helper setup in GUI, where the
    simulated filesystem parameters can include as a last component a
    file size for the simulated files.
-   **VFS-8045** Web GUI: added QoS audit log view.
-   **VFS-8041** Added basic log entries to workflow execution and task
    execution audit logs.
-   **VFS-8033** Introduced the possibility to pause and resume
    executions. Refined the phases of workflow execution and granularity
    of statuses on lane/parallel box/task levels.
-   **VFS-8018** Added HTTP storage driver option to limit on the client
    side maximum number of requests per single session, after which the
    session is closed and reconnected.
-   **VFS-7976** Ported oneclient communicator async event stream
    implementation from asio to folly IOThreadPoolExecutor.
-   **VFS-7975** Added possibility to cancel running automation
    workflow.
-   **VFS-7960** Fixed navigating through multiple spaces during files
    upload in GUI.
-   **VFS-7947** Added possibility to run workflows directly from file
    browser.
-   **VFS-7930** Web GUI: improved UX of creating incremental archives
    using archive context menu.
-   **VFS-7904** Add system audit log for each workflow execution and
    each task in the execution, with the possibility to append custom
    logs during lambda execution (using the result mappers).
-   **VFS-7898** Web GUI: added self-shortening links to files with
    support for files inside archives.
-   **VFS-7892** Improved write performance on object storages by
    minimizing the number of memory copying from Erlang to C++.
-   **VFS-7880** Introduce the concept of automation; tools for defining
    and executing automated workflows, made up of lambdas that are
    submitted to a local OpenFaaS platform. These functionalities
    currently have experimental status.
-   **VFS-7863** Web GUI: Fixed file download in iOS Safari.
-   **VFS-7856** Web GUI: added support for uploading, creating
    directories and renaming files in files selector.
-   **VFS-7846** Added action "Upload BagIt" to file browser, which is
    available when OpenFaaS and special "BagIt uploader" workflow are
    available.
-   **VFS-7817** GUI improvements in automation GUI: added navigation
    via URL to specific execution, creating stores during task and lane
    creation, showing inventory name for each execution entry.
-   **VFS-7808** Added support for symbolic links resolution during TAR
    download. By default all symbolic links are resolved.
-   **VFS-7796** Added support for navigating through symlinked
    directories without changing active directory path.
-   **VFS-7780** Added support for creating incremental archives, which
    results in storing only files that have changed in comparison to the
    base archive while unchanged files are preserved as hard links to
    the corresponding files in the base archive.
-   **VFS-7779** Added REST API for CRUD operations on file using
    relative paths.
-   **VFS-7747** Upgrade the codebase to Erlang OTP 24.
-   **VFS-7738** Fixed issues with navigation between datasets, archives
    and archive files browsers.
-   **VFS-7736** Fixed latency and timeout simulation in nulldevice
    storage helper.
-   **VFS-7728** Introduced versioning of lambdas and workflow schemas.
    Users may create subsequent revisions of the above models and modify
    their statuses (draft, stable, deprecated) to simplify management
    and retain backward compatibility of definitions that are already in
    use.
-   **VFS-7724** Web GUI: redesigned datasets and archives browser to
    browse datasets tree and archives in single splitted view.
-   **VFS-7705** Added more file actions to archive file browser GUI:
    share, metadata, permissions read, data distribution and quality of
    service.
-   **VFS-7702** Add basic REST API for scheduling and retrieving
    workflow executions.
-   **VFS-7692** Added stopped automation workflow execution discard
    functionality.
-   **VFS-7664** It is now possible to configure symbolic links policy
    when creating an archive. By default symbolic links in dataset are
    resolved resulting in link target being archived.
-   **VFS-7663** Changed background image of sign-in page in Onezone and
    Onepanel.
-   **VFS-7653** Added support for creating Dissemination Information
    Package (DIP) alongside with Archival Information Package (AIP).
-   **VFS-7651** Implement dataset archivization with BagIt layout.
-   **VFS-7649** Added support for purging archives in GUI.
-   **VFS-7648** Added Web GUI views for browsing and creating datasets
    and archives.
-   **VFS-7633** UX improvements in web GUI concerning navigation
    between files, datasets and archives using hyperlinks.
-   **VFS-7631** Web GUI: added presentation of source file path in
    dataset browser.
-   **VFS-7629** Web GUI: added new datasets panel with archives browser
    in file browser.
-   **VFS-7617** Implemented archive recall functionality, used to copy
    the archive contents to a specified destination within the space
    scope.
-   **VFS-7592** Added support for the Range header during directory or
    multi file (bulk) downloads, making it possible to resume them in
    case of interruption or network failure.
-   **VFS-7589** Added StorageRouter and BufferedStorage helpers to
    handling of aggregate storages such as archive storage.
-   **VFS-7575** Add the possibility to incorporate an XRootD server
    within the Onedata environment for exposing Open Data collections
    for public access using the XRootD protocol.
-   **VFS-7512** Web GUI: redesigned file tags with information about
    inherited QoS and datasets properties.
-   **VFS-7510** Add API for browsing dataset structures, separately for
    datasets in attached and detached state. The datasets can be listed
    using batches of requested size, with desired starting point and
    offset.
-   **VFS-7486** Added option to nulldevice helper allowing control of
    file size returned by getattr in simulated file systems.
-   **VFS-7429** Implemented the concept of datasets. Datasets allow the
    space users to organize their data into collections with desired
    granularity. A file or directory marked as a dataset offers
    additional features, such as optional data and metadata protection
    or the ability to create persistent snapshots of the physical
    dataset contents. In case of a directory, a dataset covers all its
    subdirectories and files. Datasets can be nested, allowing users to
    compose arbitrary hierarchical structures. Added corresponding views
    for managing datasets and write protection flags in file browser Web
    GUI and a REST API, accessible under `/datasets`,
    `/datasets/{DatasetId}` and `/data/{FileId}/dataset/summary` paths.
-   **VFS-7428** Added support for hard links and symlinks. Added
    corresponding REST api specific for hard and symbolic links,
    accessible under /data/{FileId}/hardlinks and
    /data/{FileId}/symlink\_value paths.
-   **VFS-7378** Removed deprecated Oneprovider REST API. The modern
    API, available since versions 20.02.\*, operates on file IDs rather
    than paths. A special endpoint for resolving file IDs based on paths
    is available.
-   **VFS-7351** It is now possible to download directories and multiple
    files via gui as a compressed TAR archive.
-   **VFS-7329** Added automation GUI - inventories, lambdas and
    workflows views in Onezone and workflows execution overview in
    Oneprovider.
-   **VFS-7305** Basic support for hard links and symbolic links on the
    filesystem level, interaction with high-level mechanisms such as
    data transfers, storage import or QoS is still to be refined.
-   **VFS-7304** Add preliminary REST API for dataset archivization - to
    be extended in near future.

### 20.02.19

-   **VFS-9926** Web GUI: Opening Oneprovider view in Onezone GUI when
    entering Oneprovider domain.
-   **VFS-9730** Improve handling of api caveats related to API
    operations concerning other components than Onezone - in some cases,
    tokens with such caveats could be treated as invalid.
-   **VFS-10012** Web GUI: Fixed hanging file upload bug when multiple
    uploads have been scheduled.

### 20.02.18

### 20.02.17

-   **VFS-9415** Improved display of sensitive storage config details in
    Onepanel GUI to show censored values instead of hiding them
    completely.

### 20.02.16

-   **VFS-9119** Introduced a temporary fix for uid/gid encoding of
    values outside of signed int32 range - the values are trimmed to the
    value of 2,147,483,646 for displaying in Oneclient. Full support for
    unsigned int32 range (in alignment with POSIX uid\_t and gid\_t
    types) will be introduced in the next major release.
-   **VFS-9118** Import ignores other file types than regular and
    directories (i.e., fifo, symlink).
-   **VFS-8939** Fixed a bug related to path caveats in access tokens,
    where a Oneclient user would see the names of newly created
    files/directories outside of the allowed paths (but was not able to
    access them).
-   **VFS-8828** Fixed conda packages for the stable branch 20.02.\*,
    starting with version 20.02.15 and Python 3.9.
-   **VFS-8704** Web GUI: Introduced more formatting-related functions
    and better UX of privacy policy editor in Onezone admin panel.

### 20.02.15

-   **VFS-8630** Added support for displaying optional Terms
    of Use document.
-   **VFS-8482** Added dedicated page for privacy policy
    content.
-   **VFS-8326** Web GUI: added service name and domain
    information on control panel login screen.

### 20.02.14

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
    
### 20.02.13

-   **VFS-8335** Fix a regression in proxied access to spaces (ones not
    supported by the Oneprovider serving the request) causing false
    ENOENT errors.
-   **VFS-8212** Web GUI: fixed not working current directory rename.

### 20.02.12

### 20.02.11

-   **VFS-8017** Added support for allowing setting of UID and GID in
    the admin context on the POSIX storage to be other than 0:0.
-   **VFS-8016** Added option to POSIX storage driver to use different
    root UID and GID than 0.
-   **VFS-7995** Added custom Root UID and Root GID options for POSIX
    storage.

### 20.02.10

-   **VFS-7739** Improved CPU affinity of storage driver threads in
    Oneprovider.

### 20.02.9

-   **VFS-7579** Implement simple, automatically rotated file access
    audit log, which can be optionally enabled in Oneprovider config.

### 20.02.8

-   **VFS-7517** Several bug fixes related to edge-cases when moving or
    deleting files.

### 20.02.7

-   **VFS-7466** Fixed PyFilesystem opener entrypoint allowing to create
    OnedataFS instances in Python using urls of the form
    \'onedatafs://HOST:PORT?token=\...\'.
-   **VFS-7294** Added publicly available REST endpoints for fetching
    information and data of shared files/directories. The data-related
    endpoints are offered by Onezone, which redirects to a suitable
    Oneprovider so that a guest user does not need any knowledge of the
    environment to access the data. Improved the Web GUI's shares view
    to present the public endpoints in an easy-to-use manner.
-   **VFS-7280** Fixed page reload after Let's Encrypt certificate
    generation via Onepanel GUI.
-   **VFS-7276** Improved handling of startup errors in Oneclient,
    including more graceful handling of various exceptions and more
    informative error messages including Oneclient and Oneprovider
    compatibility and invalid token issues.
-   **VFS-7275** Improved Oneclient exception handling, including
    connection errors and invalid tokens.
-   **VFS-7274** Added SIGTERM and SIGINT handlers to Oneclient,
    ensuring that after the oneclient process is stopped by some other
    process, the mountpoint is properly released.
-   **VFS-7271** Fixed displaying shared space root directory name in
    GUI.
-   **VFS-7256** Fixed OnedataFS token refresh, which caused
    disconnection from Oneprovider after the token expired.
-   **VFS-7165** Add a workaround for Erlang's SSL implementation that
    would not reload server certificate chain when it is changed (e.g.
    after Let's Encrypt certificate regeneration).
-   **VFS-6638** Fixed handling duplicate clusters states on clusters
    list in GUI.
-   **VFS-6566** Improved UX and fixed minor issues in share views.
    Fixed inability to open share hosted by Oneprovider 19.02.x using
    Onezone 20.02.x.
-   **VFS-6289** Add support for ANONYMOUS@ principal to ACL.

### 20.02.6

-   **VFS-7182** Storage name no longer needs to be unique.
-   **VFS-7154** Improved support for preservation of attributes during
    rsync or cp commands, chown does not raise errors anymore.
-   **VFS-7119** Dropped support for OnedataFS Anaconda packages for
    Python 2, due to Python 2 EOL.
-   **VFS-6928** Fixed possible deadlock in massive parallel truncate
    operations on Ceph pools, which could\'ve affected replica eviction
    and delete operations.
-   **VFS-6802** Added visual QoS expression editor with live matching
    storages evaluation.

### 20.02.5

-   **VFS-7129** Improved connection pool management for HTTP storages,
    including minimized reconnections and DNS caching.
-   **VFS-7124** Fixed adding user mapping to LUMA local feed on POSIX
    incompatible storages.
-   **VFS-7113** Fixed original timestamp preservation during \`cp
    \--preserve=times\` or \`rsync \--times\` commands.
-   **VFS-7079** Updated the list of system extended attributes in
    oneclient, org.onedata.uuid was renamed to org.onedata.guid and
    org.onedata.file\_id now contains CDMI object id.
-   **VFS-7058** Handling detached shares after files or directories
    removal in GUI.
-   **VFS-7047** Fixed possible race when using buffered helper to write
    to storage which fails after the file size has been updated.
-   **VFS-6999** Improve error reporting in entrypoints of
    oneprovider/onezone dockers, always dump application logs to stdout
    in case of failures during batch deployment.
-   **VFS-6858** Added support for cancelling storage auto-cleaning run
    using GUI.
-   **VFS-6745** Added new view with token templates in tokens creator
    GUI.

### 20.02.4

-   **VFS-7015** Added I/O proxy fallback in direct access mode in
    Oneclient, allowing to access files for which permissions on a
    specific storage are not properly configured, even when global
    permissions allow access.
-   **VFS-7003** Added new counters presenting progress of current/last
    finished scan of the storage import mechanism - number of all
    processed files (\`Processed files\`) and the total number of files
    residing on the storage during the scan (\`Total storage files\`).
-   **VFS-6958** Added new endpoint that checks correctness of a QoS
    expression and returns the list of storages that match the
    expression.
-   **VFS-6940** Fix truncating of sparse files.
-   **VFS-6891** Added new REST api for file deletion, uploading and
    downloading in both normal mode and share mode, accessible under
    \`/data/{fileId}\` path.
-   **VFS-6841** Introduce unified time management in all Onedata
    components - all clusters now regularly synchronize their clocks
    with the Onezone service, the process is managed by Onepanel's
    master node.
-   **VFS-6687** Blocked file path resolutions for unsupported spaces.


### 20.02.3

-   **VFS-6967** Fixed not visible JSON and RDF metadata editors in GUI
    in Safari.
-   **VFS-6927** Optimize file blocks management to decrease memory
    usage.


### 20.02.2

-   **VFS-6925** Fixed inability to scroll down files list in Firefox on
    macOS using HiDPI display.
-   **VFS-6853** Matching session cookie is now required to verify a GUI
    access tokens (they are used behind the scenes by the Onedata web
    applications), which increases security.
-   **VFS-6851** Fixed a security issue in Oneprovider share GUI.
-   **VFS-6845** Prevent application from stopping until all documents
    are correctly persisted in order to improve resistance to temporary
    database errors.
-   **VFS-6746** Added available QoS parameters suggestion box in QoS
    expression editor.
-   **VFS-6732** New JSON and RDF metadata editor based on Ace Editor.
-   **VFS-6685** Added new REST API for removing custom file metadata
    (xattrs, json and rdf).
-   **VFS-6673** Added support for Archivematica, allowing to use
    Onedata spaces as Archivematica transfer sources. Oneclient now has
    a special command line flag --enable-archivematica, which toggles
    automatic generation of Archivematica configuration and metadata
    virtual files in the Fuse file system.
-   **VFS-6623** S3 storage helper now supports public buckets, which do
    not require any credentials. The access and secret keys can be left
    empty when adding storage.
-   **VFS-6577** Improve data transfer performance to object storages
    (e.g. S3) by aligning transferred block size to the object size on
    target storage, thus minimizing the overhead necessary when updating
    a file object with partial content.
-   **VFS-6570** Showing loading indicator in file browser until file is
    available for download.
-   **VFS-6535** Updated S3 SDK library to 1.8.7.
-   **VFS-6456** Show more details about lack of privileges when trying
    to perform various actions in GUI.
-   **VFS-6338** Enhanced API of the mechanism for importing existing
    data into Onedata spaces without need for copying the data. The
    mechanism is now called "storage import". Introduced modes of
    storage import: "manual" which allows for manual registration of
    files and "auto" which enables automatic detection and import of
    files from the storage. Introduced possibility to forcefully
    start/stop scans of auto storage import. Redesigned GUI related to
    storage import, adjusted to the new features.


### 20.02.1

-   **VFS-6668** Fix bug resulting in timeouts of workers after 30s.
-   **VFS-6645** Optimize changes querrying.
-   **VFS-6628** Extended harvesting configuration - it is now possible
    to select harvesting options, like metadata types to harvest or
    additional file details (fileName, spaceId), upon index creation.
    New metadata types are now harvestable - xattrs and rdf. Default
    values of HarvestingBackendType and HarvestingBackendEndpoint can
    now be set by Onezone admin - if set, these values can be omitted
    when creating a new harvester. New option (retry\_on\_rejection)
    allowing for all payloads rejected by the harvesting backend to be
    automatically analysed for offending data (e.g. fields that do not
    match the schema), pruned and submitted again.
-   **VFS-6580** Fixed bug that could block dbsync on-demand streams on
    multi-node deployments.
-   **VFS-6577** Improve data transfer performance to object storages
    (e.g. S3) by aligning transferred block size to the object size on
    target storage, thus minimizing the overhead necessary when updating
    a file object with partial content.
-   **VFS-6568** Introduced concept of readonly storage. If enabled,
    Oneprovider will block any operation that writes, modifies or
    deletes data on the storage. Such storage can only be used to import
    data into the space. Mandatory to ensure proper behaviour if the
    backend storage is actually configured as readonly.
-   **VFS-6547** Fixed switching between spaces in file browser GUI
    during upload.
-   **VFS-6535** Updated S3 SDK library to 1.8.7.
-   **VFS-6504** Added HTTP storage helper allowing registration of HTTP
    and HTTPS servers as storage sources for Onedata Spaces.
-   **VFS-6494** Introduced REST API for registering files.
-   **VFS-6474** Added initial support for XRootD storage, including
    direct access to XRootD storages and importing of legacy data sets
    stored on XRootD or EOS servers.
-   **VFS-6457** Added new publicly visible field to shares -
    description (supports the markdown format).
-   **VFS-6456** Do not allow the user to perform actions in the GUI
    related to transfers without the appropriate permissions.
-   **VFS-6455** Support for jumping to selected files in GUI, even if
    they are not visible on infinite-scroll list.
-   **VFS-6453** New Open Data and share description views with visual
    Dublin Core editor and Markdown editor.
-   **VFS-6450** Added file name and space id to harvested file
    metadata.
-   **VFS-6431** Added performance logs for object storages, which can
    generate CSV file containing all storage requests including their
    duration.
-   **VFS-6421** New generic GUI plugin for harvesters.
-   **VFS-6378** Onepanel GUI and REST API now explicitly block
    supporting a space with more than one imported storage (globally) -
    such operation was possible in the past but was never supported by
    the internal storage import logic and led to incoherent view on
    space data.
-   **VFS-6370** Create secure fold mechanism on model documents.
-   **VFS-6361** Added new REST api for creating transfers and viewing
    file distribution, accessible respectively under \`/transfers\` and
    \`/data/{fileId}/distribution\` paths. Old \`/replicas\`,
    \`/replicas-id\` and \`/replicas-view\` endpoints were deprecated
    and will be removed in next major release.
-   **VFS-6358** Optimization of files upload through GUI.
-   **VFS-6346** GUI improvements: added Oneprovider GUI notifications,
    better file selection, additional error handling, better file
    manager refresh UX, fixed overflow of context menu in file browser,
    fixes in responsive layout.
-   **VFS-6344** GUI: showing information if QoS requirement is
    impossible to be fulfilled.
-   **VFS-6343** Added delete account feature in GUI.
-   **VFS-6320** Old \`/spaces/{sid}/indexes\`,
    \`/spaces/{sid}/indexes/{index\_name}\`,
    \`/spaces/{sid}/indexes/{index\_name}/reduce\` and
    \`/spaces/{sid}/indexes/{index\_name}/query\` endpoints were
    deprecated and will be removed in next major release.
-   **VFS-6316** Added \`statfs\` support enabling preview of available
    storage in each space through oneclient, for instance using \`df\`
    or \`stat\` utilities.
-   **VFS-6288** Basic HA functionality (experimental) - protect
    Oneprovider from single node failure.
-   **VFS-6287** Integrate traverse pools with HA sub-system.
-   **VFS-6263** New experimental Quality of Service functionality. It
    is used to manage file replica distribution and redundancy between
    supporting Oneproviders. Users can define any number of QoS
    requirements for a file or directory. Each requirement consists of
    target replicas number and an expression that is used to select
    storages where the replicas should be placed ‐ it is matched against
    parameters that were assigned to storages by Oneprovider admins.
-   **VFS-6261** Integrate high-level services with HA sub-system.
-   **VFS-6225** Added new \`triggers\` field to changes stream
    specification allowing to send events only on specified docs types
    changes.
-   **VFS-6184** Added the space owner concept. Space owner works like
    \"root\" within the space - such user is allowed to perform all
    file/API operations, regardless of the assigned privileges and file
    permissions / ACLs. Ownership can be assigned to any number of
    users, and it is forbidden to leave a space without an owner -
    ownership must be transferred first.
-   **VFS-6167** Allow nodes adding and deleting in-fly basing on HA
    sub-system.
-   **VFS-6160** Reorganized Local User Mapping (LUMA) management.
    Introduced feeds for populating LUMA DB.
-   **VFS-6095** Mask private file attributes, such as uid or gid, when
    showing file attrs in share mode.
-   **VFS-5648** Extended QoS expression to allow comparators (\<, \>,
    \<=, \>=) and numeric values. Changed \"-\" operator to \"\\\".
    Space characters (\" \"), dashes (\"-\") and underscores (\"\_\")
    are now allowed in QoS parameters. Added more details to invalid QoS
    expression errors.
-   **VFS-4760** Added implicit API caveats that limit access tokens
    used by Onedata GUIs behind the scenes for authentication and
    authorization. Different services in the system are presented with
    user\'s access token with power limited to bare minimum required for
    the service to handle user requests. For example, Oneproviders do
    not have access to APIs that could alter or delete user data and
    memberships.

### 20.02.0-beta4

-   **VFS-6359** Fixed an issue with accessing files in spaces which are
    not supported by the Oneprovider instance to which Oneclient is
    currently connected.
-   **VFS-6356** Fixed an error with caching of file location map in
    Oneclient, which resulted in data access errors in case of
    invalidation of replicas on Oneprovider.

### 20.02.0-beta3

-   VFS-6131 Account for changes in emergency passphrase api changes
-   VFS-5838 entrypoint: Accept any 2xx and 3xx HTTP codes as success
-   VFS-5841 entrypoint: Use PyYAML\'s safe loader to silence a
    warning
-   VFS-5841 Parse deployment error using new onepanel errors format
-   VFS-5698 Add Ceph directories to persistence
-   VFS-5698 Add Ceph shutdown to entrypoint script
-   VFS-5698 Add Ceph installation to dockerfile
-   VFS-5742 Disabled http\_proxy for normal operation
-   VFS-5742 Disabled yum mirrors for package tests
-   VFS-5742 Disabled yum proxy for package tests
-   VFS-5742 Enabled proxy cache for package tests
-   VFS-5742 Enabled proxy cache for docker builds
-   VFS-5714 Added custom conda build options make arguments
-   VFS-5714 Added onedatafs\_jupyter\_conda rule
-   VFS-5714 Added fs.onedatafs conda rule
-   VFS-5714 Added oneclient conda rules

### 19.02.5

-   **VFS-6857** Add support for resuming partial file downloads via
    CDMI.

### 19.02.4

-   **VFS-6635** Improve synchronization retries politics to prevent
    synchronizer blocking by dead providers.
-   **VFS-6631** Rtransfer takes into account storage block size
    choosing blocks to synchronize.
-   **VFS-6607** Fix node restart with HA disabled.
-   **VFS-6587** Replica synchronizer takes into account storage blocks
    size during choice of blocks to be replicated.
-   **VFS-6578** Fix events manager initialization to prevent races
    between events.
-   **VFS-6540** Files upload GUI optimization using optimal (per space)
    upload file chunk size.
-   **VFS-6438** Decrease overhead of transfers of already replicated
    files. Optimization of on demand synchronization streams usage.
-   **VFS-6401** All authentication errors are now wrapped in
    UNAUTHORIZED error and map to 401 HTTP code to avoid ambiguity when
    reporting token related errors - tokens can be used for
    authentication as well as input data for some operations (e.g.
    invite tokens).
-   **VFS-6390** Because of asynchronous processing, it was possible
    that GraphSync session cleanup intertwined with deleted record
    cleanup (that removes corresponding subscriptions from sessions,
    possibly including the session being cleaned up) and caused an error
    that interrupted change propagation. Now, if the session is no
    longer existent, subscription removal errors are ignored and the
    propagation completes.
-   **VFS-6369** Fix datastore internal call, batch management during
    links listing and infinite loop during storage directories creation.

### 19.02.3

- Minor bugfixes

### 19.02.2

- Bugfixes and stability improvements

### 19.02.1

-   VFS-5884 Added print\_package\_versions makefile rule

##### op-worker

-   Bump version to 19.02.1
-   VFS-5826 Ensure db start at cluster init
-   VFS-5900 GUI update \* Added showing special subjects in ACL editor
-   VFS-5826 Add missing event during dir creation
-   VFS-5891 Clean authorization nonce after its TTL
-   VFS-5826 Add events during file creation
-   VFS-5826 Change max\_read\_dir\_plus\_procs value
-   VFS-5826 Emmit attr\_changed events on chmod and acl change
-   VFS-5826 Change events processing - allow subscriptions per dir

##### onepanel

-   VFS-5994 Make \'production\' Let\'s Encrypt mode the default
-   VFS-5940 Rename oz-worker\'s GUI package verification envs to more
    intuitive

##### oneclient

-   VFS-5826 Increased events test connections
-   VFS-5826 Added opendir and releasedir to OnedataFS
-   VFS-5826 Increased default metadata cache size
-   VFS-5826 Added support for opendir and releasedir
-   VFS-5826 Added persistent directory cache
-   VFS-5826 Added directory subscription cancelling
-   VFS-5844 Refactored metadatacache to limit file subscriptions
-   VFS-5965 Added option to emulate large available space

### 19.02.0-rc2

-   VFS-5742 Disabled http\_proxy for normal operation
-   VFS-5742 Disabled yum mirrors for package tests
-   VFS-5742 Disabled yum proxy for package tests
-   VFS-5742 Enabled proxy cache for package tests
-   VFS-5742 Enabled proxy cache for docker builds

### 19.02.0-rc1

-   VFS-5660 Disabled RANDFILE to enable certificate creation in Docker
-   VFS-5660 Added libssl1.0.0 dependency to Docker
-   VFS-5657 Fixed Dockerfile for tagged ubuntu packages
-   VFS-5657 Enabled bionic packaging tests
-   VFS-5535 Added onedatafs-jupyter docker make rule
-   VFS-5563 Added onedatafs-jupyter submodule
-   VFS-5535 Fixed CentOS onedatafs-jupyter package builds

### 18.02.3

-   Releasing new version 18.02.3

### 18.02.2

-   Update submodules
-   VFS-5436 Fixed oneclient packaging tests
-   VFS-5436 Fixed Oneprovider packaging tests
-   VFS-5434 Fixed CentOS package tests
-   VFS-5053 Updated worker and builder versions

### 18.02.1

-   VFS-5154 Fixed Oneprovider packaging tests

### 18.02.0-rc13

-   VFS-5001 Changed auth provider selector
-   Fix locale settings in Oneprovider docker
-   fix fetching token from oz

### 18.02.0-rc12

-   Releasing new version 18.02.0-rc12

### 18.02.0-rc11

-   Releasing new version 18.02.0-rc11

### 18.02.0-rc10

-   Releasing new version 18.02.0-rc10

### 18.02.0-rc9

-   VFS-4532 Create new config file instead of using regexps
-   VFS-4482 Changed transfer tabs names
-   VFS-4367 Make docker entrpoint consistent with onezone.py
-   VFS-4367 Expect 409 when configuring existing cluster
-   VFS-4367 Do not fail cluster restart when admin credentials are
    missing
-   VFS-4521 Adjusted sysbench performance test parameters
-   VFS-4521 change deprecated sysbench options
-   VFS-4521 upgrade sysbench performance test

### 18.02.0-rc8

-   Releasing new version 18.02.0-rc8

### 18.02.0-rc7

-   VFS-4474 Display error details on configuration error
-   VFS-4278 Better detection of bad credentials error in entrypoint
-   VFS-4470 Changed asserted transferred files

### 18.02.0-rc6

-   Releasing new version 18.02.0-rc6

### 18.02.0-rc5

-   VFS-4480 Remove home provider test as it this feature was removed

### 18.02.0-rc4

-   VFS-4278 Use nagios to wait for cluster to resume work
-   VFS-4278 Fetch batch config only when needed
-   VFS-4278 Allow failed configuration for existing provider
-   VFS-4278 Remove setting onezone domain from entrypoint
-   VFS-4278 Start services on restart

### 18.02.0-rc3

-   Releasing new version 18.02.0-rc3

### 18.02.0-rc2

-   VFS-4327 Added wt decorator
-   VFS-4343 Added tabs in transfer tests
-   VFS-4343 Updated transfers tests
-   VFS-4365 Backporting scroll improvement and OSX support for GUI
    tests
-   VFS-4327 Added check with stat if file exists

### 18.02.0-rc1

-   VFS-2021 Added dockers.config
-   VFS-4376 Tests updated after removing sticky\_bit
-   VFS-4362 Removing symlinks from logs after env\_up teardown
-   VFS-4369 fix acceptance tests after removing sticky bit

### 18.02.0-beta6

-   Releasing new version 18.02.0-beta6

### 18.02.0-beta5

-   VFS-4333 Decresed test logging delay in file creation tests
-   VFS-4333 Disabled gdb by default
-   VFS-3622 Merged docker-dev with docker. Added possibility to run
    services from sources.

### 18.02.0-beta4

-   Releasing new version 18.02.0-beta4

### 18.02.0-beta3

-   VFS-4213 Change the way persistent volume is created to allow for
    mounting single files inside it

### 18.02.0-beta2

-   VFS-4126 Remove obsolete port exposes from Dockerfiles
-   VFS-4099 Changed selenium get url to javascript

### 18.02.0-beta1

-   Releasing new version 18.02.0-beta1

### 17.06.2

-   Releasing new version 17.06.2

### 17.06.1

-   Releasing new version 17.06.1

### 17.06.0-rc9

-   VFS-3977 Remove oneclient-base from docker-dev image
-   VFS-3877 Removed self-contained-html from gui acceptance tests
-   VFS-3877 Added tmp\_files to gitignore
-   VFS-3877 Implemented GUI acceptance tests for transfers
-   VFS-3862 Add more verbose log when oneprovider configuration script
    fails

### 17.06.0-rc8

-   VFS-3815 Modified packaging tests for CentOS 7

### 17.06.0-rc7

-   Releasing new version 17.06.0-rc7

### 17.06.0-rc6

-   Releasing new version 17.06.0-rc6

### 17.06.0-rc5

-   Releasing new version 17.06.0-rc5

### 17.06.0-rc4

-   VFS-3682 Added self-contained Oneclient packaging

### 17.06.0-rc3

-   VFS-3656 Removed support for Ubuntu Wily
-   VFS-3517 Added tests checking timestamps after renaming item in GUI
    to xfail due to VFS-3520
-   VFS-3517 Changed amount of time to wait between creating and
    renaming space
-   VFS-3515 add additional logs to performance tests
-   VFS-3281 Added extended attributes acceptance tests

### 17.06.0-rc2

-   VFS-3434 Multiuser tests implemented
-   VFS-3465 flush stdout after prints in performance tests
-   VFS-3465 split tests/gui/scenarios into modules and add -s option to
    performance tests
-   VFS-3465 add additional logging to performance tests
-   VFS-3434 POSIX privileges mixed tests implemented
-   VFS-3434 Added \--self-contained-html to test\_acceptance\_mixed
-   VFS-3434 Posix privileges gui steps added

### 17.06.0-rc1

-   VFS-3407 Mixed tests (GUI and oneclient)

### 17.06.0-beta6

-   VFS-3358 fix steps managing btns in toolbar in data tab in op after
    changes in gui
-   VFS-3284 GUI tests: using new go to your files button
-   VFS-3322 add 10000 files creation performance test

### 17.06.0-beta4

-   VFS-3347 Add docker-dev build

### 17.06.0-beta3

-   VFS-3353 Enable user name/email set in `update_refs.sh`
-   VFS-3340 GUI acceptance tests update: changed timeouts, get support
    modal tests
-   Releasing new version 17.06.0-beta3

### 17.06.0-beta2

-   VFS-3348 Update couchbase version to 4.5.1

### 3.0.0-rc16

-   VFS-3184 Add copy/remove tests.
-   VFS-3017 Check if mtime and ctime are equal after rename (in
    previous implemetation of rename they were greater).

### 3.0.0-rc15

-   Update refs to origin/release/3.0.0-rc15.
-   VFS-3197 Enable release docker to log to stdout
-   Update refs to
    origin/feature/VFS-3213-change-storage-verification-mechanism.
-   VFS-3051 add clipboard fixture and replace pyperclip uses with it
-   VFS-3051 enhance logging capabilities
-   VFS-3051 add support for recording tests with multiple browsers
-   implement changes to allow splitting acceptance tests on bamboo
-   VFS-3051 add support for logs from multiple browsers

### 3.0.0-rc14

-   VFS-3101 change Then steps in metadata scenarios
-   VFS-3101 refactor metadata steps
-   VFS-3101 add ButtonWebObject class
-   VFS-3050 add test for 2 providers
-   VFS-3050 add steps creating access token and copying providers ip
    for cdmi use
-   VFS-3050 add provisional api for handling cdmi service from tests
-   VFS-3050 refactor web\_elements.py
-   VFS-3050 add test user upload file on 1 provider and download on
    other
-   VFS-3050 add utils for handling of file distribution modal and
    canvas

### 3.0.0-rc13

-   Releasing new version 3.0.0-rc13

### 3.0.0-rc12

-   Enable graceful stop on SIGTERM
-   Add oneprovider users and groups in Dockerfile
-   Update refs to origin/release/3.0.0-rc12.
-   VFS-2910 Adjust tests to LUMA refactoring
-   VFS-2725 improve logging in acceptance tests, all tests in
    directory\_CRUD addapted to new logging, all of them pass
    successfully
-   VFS-2551 add test to set space as home in oz
-   VFS-2551 add tests for data space management
-   VFS-2551 add tests for user alies and access tokens

### 3.0.0-rc11

-   VFS-2733 Fix provider key/cert filename
-   VFS-2739 make msg for assertion more descriptive
-   VFS-2739 rewrite msg on assertions
-   VFS-2739 use tmpdir pytest fixture instead of os to crete tmpdir and
    files
-   VFS-2739 add msg to assertions
-   VFS-2739 change click on file -\> select file in shares test
-   VFS-2739 add test to select multiple files witch ctrl
-   VFS-2739 add cleaning to upload many files test
-   VFS-2739 add paging test
-   VFS-2733 Add excluded path to docker entrypoint
-   VFS-2549 fix checking content of downloaded file step
-   VFS-2549 change url-\>URL, id-\>ID in gherkin steps
-   VFS-2549 add quotes to files/dirs in shares tests steps in gherkin
-   VFS-2549 add quotes to file/dir names in data and metadata features
-   VFS-2549 add quotation marks to names of groups/spaces/shares/\...
-   VFS-2549 fix closing notifies
-   VFS-2549 fix scenario names in group and share tests
-   VFS-2564 add test checking that user can\'t view left group
-   VFS-2616 add test checking if user can view group having it\'s id
-   VFS-2549 fix waiting for notifies to disappear and switching spaces
-   VFS-2549 remove import of non existing module file\_system
-   VFS-2634 refactor share tests
-   VFS-2634 fix step fun definitions, add new share tests
-   VFS-2634 refactor modals and file list steps, add sidebar list steps
-   VFS-2634 fix modal and file list steps

### 3.0.0-rc10

-   Releasing new version 3.0.0-rc10
-   VFS-2714 print gherkin-reports in acceptance tests after pytest-bdd
    update

### 3.0.0-rc9

-   VFS-2617 Changed metadata submenu to metadata panel

### 3.0.0-rc8

-   Releasing new version 3.0.0-rc8
-   VFS-2549 Add tests for public readonly share: add file, remove file,
    jump no breadcrumbs
-   VFS-2549 Fix share tests to work with new gui
-   VFS-2549 Add 2 new tests for shares: recursive delete, jumping in
    breadcrumbs
-   VFS-2549 Fix share multi test
-   VFS-2634 Fix tests to work with new gui, add new share tests
-   VFS-2634 Fix share steps, add 2 new scenarios

### 3.0.0-rc7

-   VFS-2549 Add share tests for multiple browsers: download, rename,
    remove

### 3.0.0-rc6

-   VFS-2180 Improve links conflict resolution
-   VFS-2180 Improve dbsync implementation
-   VFS-2180 Use gen\_server2 instead of erlang\'s gen\_server module
-   VFS-2390 Fix handlers specification in REST API
-   VFS-2390 Update rebar to version 3
-   Update memory management
-   VFS-2180 Allow for concurrent file creation
-   VFS-2202 modify README.md
-   VFS-2202 fix step name of step creating webdriver instances
-   VFS-2202 remake givens to work with multiple browsers
-   VFS-2202 add join group test
-   VFS-2202 remake use of pytest\_selenium\_multi fixtures
-   VFS-2202 remake firefox profile as factory

### 3.0.0-rc5

-   Update interfaces
-   Increase system performance
-   VFS-2534 Improve events processing
-   Update one panel for extended configuration options
-   VFS-2527 Use sbin/init as docker entrypoint
-   VFS-2449 fix step names and activating input box
-   VFS-2476 Add events profiling tests
-   VFS-2449 fix entering text to input box
-   VFS-2449 add msg to wait(\...).until(\..., msg=\...)
-   VFS-2450 fail test instead of skipping if setting up environment
    fails
-   VFS-2454 add download test for firefox
-   VFS-2454 add download test for chrome

### 3.0.0-rc4

-   Add ONEPANEL\_DEBUG\_MODE env variable to release docker entrypoint

### 3.0.0-RC3

-   VFS-2156 Update release docker
-   VFS-2156 Update packages tests
-   VFS-2395 Fix given step for checking provider\'s name in file
    distribution
-   VFS-2395 Fix given for data spaces and renamed some steps for spaces
    tests
-   VFS-2395 Added scrolling to element when clicking settings icon.
-   VFS-2395 Refactorize functions for creating space in onezone

### 3.0.0-RC2

-   Turn off HSTS by default, allow configuration via app.config
-   Update file consistency management
-   Enable metadata caching
-   Extend support for user-defined metadata
-   Update Web\_GUI and REST API
-   added NO\_CACHE option to makefile
-   Enable Symmetric Multiprocessing
-   Use environment variables for packages build

### 3.0.0-RC1

-   Tests refactoring
-   Several op\_worker stability improvements
-   Extend op\_worker system monitoring
-   Update session management
-   VFS-2316 Update etls.
-   Improve client stability
-   VFS-1963 Improve automatic storage discovery
-   VFS-2270 Print out the hostname of client\'s provider.

### 3.0.0-beta8

-   Additional GUI model relations
-   Update ACL and protocol
-   Change error on sync fail
-   Add file redirection to rename

### 3.0.0-beta7

-   Improve GUI
-   Improve dbsync reliability and performance
-   Adjust to new client API

### 3.0.0-beta6

-   Add prefetching
-   Add support for S3
-   Add quota implementation
-   Extend REST api

### 3.0.0-beta5

-   Metadata synchronization between providers improved.
-   Support for nested groups.

### 3.0.0-beta4

-   Rename redeisgned.

### 3.0.0-beta3

-   GUI update
-   Provider proxy channel added
-   Faster proxy for oneclient
-   LUMA integrated
-   Code covering

### 3.0.0-beta1

-   New oneclient with faster proxy and SMB
-   New op\_worker with subscriptions and new GUI
-   VFS-1804 Add redirection point to oneprovider config.
-   VFS-1804 Adjust packaging tests config files.
-   VFS-1757 Fix onedata deinstallation.
-   Update environment descriptions, remove bamboos compilation.
-   VFS-1788 Use onezone artifact during onedata packages tests.

### 3.0.0-alpha3

-   VFS-1677 - using get\_cookie function instead of hardcoding cookie
    in get\_token.escript
-   VFS-1684 - bring env up by calling run\_env\_up\_script in cucumber
    tests
-   VFS-1677-cucumber test generator sketch
-   VFS-1684 - add build\_onepanel target to Makefile
-   VFS-1657 Add system update to release dockers.
-   VFS-1544 makefile rebranding
-   VFS-1544 onezone rebranding

### 3.0.0-aplha

-   VFS-1621 Add release dockerfile.
-   Add vivid repo to pkg.py script.
-   Do not exit when deployment of one package fails.
-   VFS-1583- save logs from acceptance\_tests
-   VFS-1583-add timestamps to logdir names
-   VFS-1583-save logs from cucumber tests in tests/cucumber/logs
-   VFS-1628 Remove unnecessary options and sign rpms without asking for
    password in pkg.py script.
-   VFS-1603 Bump fedora-systemd version to comply with parent image -
    fedora 23.
-   VFS-1603 Fix RPM package installation test.
-   VFS-1628 Improve pkg.py script.
-   Increasing timeouts in appmock tcp tests
-   VFS-1603 Adjust pkg.py script to wily deb package.
-   VFS-1603 Fix oneprovider deinstallation.
-   VFS-1603 Adjust tests to the new packages.
-   VFS-1505 Enabling and improving timestamps tests

### 3.0.0-prealpha1

-   Dockerized environment provided.
-   Acceptance tests in GHERKIN.
-   Unit, integration and acceptance tests provided.
-   Appmock for tests provided.
-   Onepanel for simple installation provided.
-   Global Registry provided.
-   Oneclient provided.
-   Oneprovider composed of op-worker and cluster-manager provided.

------------------------------------------------------------------------

