/*
    Author: John Kerski

    Description: Connector wraps many of the "Get" endpoints in the Power BI API (with the exception of ExecuteQuery),
    so that OAuth can be used to authenticate to the service.  This connector serves
    as a way to have a library of Power Query functions to build datasets without the need
    for storing client secrets or passwords in the dataset.  The custom data connector will need
    to be installed in the a Power BI Gateway in order to refresh datasets leveraging this
    custom connector.  For more information on installing a custom data connector with a gateway
    please see: https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-custom-connectors .
*/
[Version = "1.1.0"]
section PBIRESTAPIGCC;
[
    DataSource.Kind = "PBIRESTAPIGCC",
    Publish = "PBIRESTAPIGCC.Publish"
]
/*****************
    Navigation Table
*****************/
shared NavigationTable.Simple = () =>
let
	objects = #table(
            {"Name","Key","Data","ItemKind","ItemName","IsLeaf"},{
            /* Apps */
            {"GetApp","GetApp",PBIRESTAPIGCC.GetApp,"Function","GetApp",true},
            {"GetApps","GetApps",PBIRESTAPIGCC.GetApps,"Function","GetApps",true},
            {"GetDashboardInApp","GetDashboardInApp",PBIRESTAPIGCC.GetDashboardInApp,"Function","GetDashboardInApp",true},
            {"GetDashboardsInApp","GetDashboardsInApp",PBIRESTAPIGCC.GetDashboardsInApp,"Function","GetDashboardsInApp",true},  
            {"GetReportInApp","GetReportInApp",PBIRESTAPIGCC.GetReportInApp,"Function","GetReportInApp",true},
            {"GetReportsInApp","GetReportsInApp",PBIRESTAPIGCC.GetReportsInApp,"Function","GetReportsInApp",true},                      
            /* Datasets */
            {"GetDatasetInGroup","GetDatasetInGroup",PBIRESTAPIGCC.GetDatasetInGroup,"Function","GetDatasetInGroup",true},
            {"GetDatasetToDataflowsLinksInGroup","GetDatasetToDataflowsLinksInGroup",PBIRESTAPIGCC.GetDatasetToDataflowsLinksInGroup,"Function","GetDatasetToDataflowsLinksInGroup",true},
            {"GetDatasetUsersInGroup","GetDatasetUsersInGroup",PBIRESTAPIGCC.GetDatasetUsersInGroup,"Function","GetDatasetUsersInGroup",true},
            {"GetDatasetsInGroup","GetDatasetsInGroup",PBIRESTAPIGCC.GetDatasetsInGroup,"Function","GetDatasetsInGroup",true},
            {"GetDatasetDatasourcesInGroup","GetDatasetDatasourcesInGroup",PBIRESTAPIGCC.GetDatasetDatasourcesInGroup,"Function","GetDatasetDatasourcesInGroup",true},
            {"GetDatasetDirectQueryRefreshScheduleInGroup","GetDatasetDirectQueryRefreshScheduleInGroup",PBIRESTAPIGCC.GetDatasetDirectQueryRefreshScheduleInGroup,"Function","GetDatasetDirectQueryRefreshScheduleInGroup",true},
            {"GetDatasetParametersInGroup","GetDatasetParametersInGroup",PBIRESTAPIGCC.GetDatasetParametersInGroup,"Function","GetDatasetParametersInGroup",true},
            {"GetDatasetRefreshExecutionDetailsInGroup","GetDatasetRefreshExecutionDetailsInGroup",PBIRESTAPIGCC.GetDatasetRefreshExecutionDetailsInGroup,"Function","GetDatasetRefreshExecutionDetailsInGroup",true},
            {"GetDatasetRefreshHistoryInGroup","GetDatasetRefreshHistoryInGroup",PBIRESTAPIGCC.GetDatasetRefreshHistoryInGroup,"Function","GetDatasetRefreshHistoryInGroup",true},
            {"GetDatasetRefreshScheduleInGroup","GetDatasetRefreshScheduleInGroup",PBIRESTAPIGCC.GetDatasetRefreshScheduleInGroup,"Function","GetDatasetRefreshScheduleInGroup",true},
            {"ExecuteQuery","ExecuteQuery",PBIRESTAPIGCC.ExecuteQuery,"Function","ExecuteQuery",true},
            {"ExecuteQueryInGroup","ExecuteQueryInGroup",PBIRESTAPIGCC.ExecuteQueryInGroup,"Function","ExecuteQueryInGroup",true},
            /* Reports */
            {"GetReportPageInGroup","GetReportPageInGroup",PBIRESTAPIGCC.GetReportPageInGroup,"Function","GetReportPageInGroup",true},
            {"GetReportPagesInGroup","GetReportPagesInGroup",PBIRESTAPIGCC.GetReportPagesInGroup,"Function","GetReportPagesInGroup",true},
            {"GetReportInGroup","GetReportInGroup",PBIRESTAPIGCC.GetReportInGroup,"Function","GetReportInGroup",true},
            {"GetReportsInGroup","GetReportsInGroup",PBIRESTAPIGCC.GetReportsInGroup,"Function","GetReportsInGroup",true},
            /* Groups */
            {"GetGroupUsers","GetGroupUsers",PBIRESTAPIGCC.GetGroupUsers,"Function","GetGroupUsers",true},
            {"GetGroups","GetGroups",PBIRESTAPIGCC.GetGroups,"Function","GetGroups",true},
            /* Pipelines */
            {"GetPipeline","GetPipeline",PBIRESTAPIGCC.GetPipeline,"Function","GetPipeline",true}, 
            {"GetPipelineOperation","GetPipelineOperation",PBIRESTAPIGCC.GetPipelineOperation,"Function","GetPipelineOperation",true},
            {"GetPipelineOperations","GetPipelineOperations",PBIRESTAPIGCC.GetPipelineOperations,"Function","GetPipelineOperations",true},
            {"GetPipelineStageArtifacts","GetPipelineStageArtifacts",PBIRESTAPIGCC.GetPipelineStageArtifacts,"Function","GetPipelineStageArtifacts",true},
            {"GetPipelineStages","GetPipelineStages",PBIRESTAPIGCC.GetPipelineStages,"Function","GetPipelineStages",true},
            {"GetPipelineUsers","GetPipelineUsers",PBIRESTAPIGCC.GetPipelineUsers,"Function","GetPipelineUsers",true},
            {"GetPipelines","GetPipelines",PBIRESTAPIGCC.GetPipelines,"Function","GetPipelines",true}                         
        }),
	navTable = Table.ForceToNavigationTable(objects, {"Key"},"Name","Data","ItemKind","ItemName","IsLeaf")
in
	navTable;

/*****************
    APPS
*****************/

/*** GetApp ***/
shared PBIRESTAPIGCC.GetApp = Value.ReplaceType(
    GetApp,
    GetAppType
);

GetAppType = type function (
    optional appId as (
        type text meta [
            Documentation.FieldCaption = "App ID",
            Documentation.FieldDescription = "The Application ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetApp",
    Documentation.LongDescription = "Returns the specified installed app.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetApp(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/apps/get-app#app"
        ]
    }
];

GetApp = (optional appId as text) =>
    let
        result = GetJSON("v1.0/myorg/apps/" & appId)
    in
        result;
/*** End GetApp ***/
/*** GetApps***/
shared PBIRESTAPIGCC.GetApps = Value.ReplaceType(
    GetApps,
    GetAppsType
);

GetAppsType = type function (
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetApps",
    Documentation.LongDescription = "Returns a list of installed apps.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetApps()",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/apps/get-apps#apps"
        ]
    }
];

GetApps = () =>
    let
        result = GetJSON("v1.0/myorg/apps")
    in
        result;
/*** End GetApps***/

/*** GetDashboard***/
shared PBIRESTAPIGCC.GetDashboardInApp = Value.ReplaceType(
    GetDashboardInApp,
    GetDashboardInAppType
);

GetDashboardInAppType = type function (
    optional appId as (
        type text meta [
            Documentation.FieldCaption = "App ID",
            Documentation.FieldDescription = "The Application ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional dashboardId as (
        type text meta [
            Documentation.FieldCaption = "Dashboard ID",
            Documentation.FieldDescription = "The Dashboard ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDashboardInApp",
    Documentation.LongDescription = "Returns the specified dashboard from the specified app.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDashboardInApp(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/apps/get-dashboard#dashboard"
        ]
    }
];

GetDashboardInApp = (optional appId as text, optional dashboardId as text) =>
    let
        result = GetJSON("v1.0/myorg/apps" & appId & "/dashboards/" & dashboardId)
    in
        result;

/*** End GetDashboard***/

/*** GetDashboards***/
shared PBIRESTAPIGCC.GetDashboardsInApp = Value.ReplaceType(
    GetDashboardsInApp,
    GetDashboardsInAppType
);

GetDashboardsInAppType = type function (
    optional appId as (
        type text meta [
            Documentation.FieldCaption = "App ID",
            Documentation.FieldDescription = "The Application ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDashboardsInApp",
    Documentation.LongDescription = "Returns a list of dashboards from the specified app.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDashboardsInApp(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/apps/get-dashboards#dashboards"
        ]
    }
];

GetDashboardsInApp = (optional appId as text) =>
    let
        result = GetJSON("v1.0/myorg/apps" & appId & "/dashboards")
    in
        result;

/*** End GetDashboards***/

/*** GetReport***/
shared PBIRESTAPIGCC.GetReportInApp = Value.ReplaceType(
    GetReportInApp,
    GetReportInAppType
);

GetReportInAppType = type function (
    optional appId as (
        type text meta [
            Documentation.FieldCaption = "App ID",
            Documentation.FieldDescription = "The Application ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional reportId as (
        type text meta [
            Documentation.FieldCaption = "Report ID",
            Documentation.FieldDescription = "The Report ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetReportInApp",
    Documentation.LongDescription = "Returns the specified report from the specified app.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetReportInApp(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/apps/get-report#report"
        ]
    }
];

GetReportInApp = (optional appId as text, optional reportId as text) =>
    let
        result = GetJSON("v1.0/myorg/apps" & appId & "/reports/" & reportId)
    in
        result;

/*** End GetReport***/

/*** GetReports***/
shared PBIRESTAPIGCC.GetReportsInApp = Value.ReplaceType(
    GetReportsInApp,
    GetReportsInAppType
);

GetReportsInAppType = type function (
    optional appId as (
        type text meta [
            Documentation.FieldCaption = "Application ID",
            Documentation.FieldDescription = "The Application ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetReportsInApp",
    Documentation.LongDescription = "Returns a list of reports from the specified app.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetReportsInApp(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/apps/get-reports#reports"
        ]
    }
];

GetReportsInApp = (optional appId as text) =>
    let
        result = GetJSON("v1.0/myorg/apps/" & appId & "/reports")
    in
        result;

/*** End GetReports***/

/*** GetTile***/
/*** End GetTile***/

/*** GetTiles***/
/*** End GetTiles***/

/*****************
    Datasets
*****************/

/*** GetDatasetInGroup***/
shared PBIRESTAPIGCC.GetDatasetInGroup = Value.ReplaceType(
    GetDatasetInGroup,
    GetDatasetInGroupType
);

GetDatasetInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )    
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetInGroup",
    Documentation.LongDescription = "Returns the specified dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-datasets-in-group#datasets"
        ]
    }
];

GetDatasetInGroup = (optional groupdId as text, optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/" & datasetId)
    in
        result;
/*** End GetDatasetInGroup***/

/*** GetDatasetToDataflowsLinksInGroup***/
shared PBIRESTAPIGCC.GetDatasetToDataflowsLinksInGroup = Value.ReplaceType(
    GetDatasetToDataflowsLinksInGroup,
    GetDatasetToDataflowsLinksInGroupType
);

GetDatasetToDataflowsLinksInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetToDataflowsLinksInGroup",
    Documentation.LongDescription = "Returns a list of upstream dataflows for datasets from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetToDataflowsLinksInGroup(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-dataset-to-dataflows-links-in-group#datasettodataflowlinksresponse"
        ]
    }
];

GetDatasetToDataflowsLinksInGroup = (optional groupdId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/upstreamDataflows")
    in
        result;
/*** End GetDatasetToDataflowsLinksInGroup***/

/*** GetDatasetsUsersInGroup***/
shared PBIRESTAPIGCC.GetDatasetUsersInGroup = Value.ReplaceType(
    GetDatasetUsersInGroup,
    GetDatasetUsersInGroupType
);

GetDatasetUsersInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyx1..."
            }
        ]
    )    
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetUsersInGroup",
    Documentation.LongDescription = "Returns a list of principals that have access to the specified dataset. When user permissions to a dataset have been recently updated, the new permissions might not be immediately available through API calls.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetUsersInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyx1..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-dataset-users-in-group#datasetusersaccess"
        ]
    }
];

GetDatasetUsersInGroup = (optional groupdId as text, optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/" & datasetId & "/users")
    in
        result;
/*** End GetDatasetUsersInGroup***/

/*** GetDatasetsInGroup***/
shared PBIRESTAPIGCC.GetDatasetsInGroup = Value.ReplaceType(
    GetDatasetsInGroup,
    GetDatasetsInGroupType
);

GetDatasetsInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetsInGroup",
    Documentation.LongDescription = "Returns a list of datasets from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetsInGroup(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-datasets-in-group#datasets"
        ]
    }
];

GetDatasetsInGroup = (optional groupdId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets")
    in
        result;
/*** End GetDatasetsInGroup***/

/*** GetDatasetDatasourcesInGroup***/
shared PBIRESTAPIGCC.GetDatasetDatasourcesInGroup = Value.ReplaceType(
    GetDatasetDatasourcesInGroup,
    GetDatasetDatasourcesInGroupType
);

GetDatasetDatasourcesInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyx1..."
            }
        ]
    )    
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetDatasourcesInGroup",
    Documentation.LongDescription = "Returns a list of data sources for the specified dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetDatasourcesInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyx1..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-datasources-in-group#datasources"
        ]
    }
];

GetDatasetDatasourcesInGroup = (optional groupdId as text, optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/" & datasetId & "/datasources")
    in
        result;
/*** End GetDatasetDatasourcesInGroup***/

/*** GetDatasetDirectQueryRefreshScheduleInGroup***/
shared PBIRESTAPIGCC.GetDatasetDirectQueryRefreshScheduleInGroup = Value.ReplaceType(
    GetDatasetDirectQueryRefreshScheduleInGroup,
    GetDatasetDirectQueryRefreshScheduleInGroupType
);

GetDatasetDirectQueryRefreshScheduleInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyx1..."
            }
        ]
    )    
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetDirectQueryRefreshScheduleInGroup",
    Documentation.LongDescription = "Returns the refresh schedule for a specified DirectQuery or LiveConnection dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetDirectQueryRefreshScheduleInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyx1..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-direct-query-refresh-schedule-in-group#directqueryrefreshschedule"
        ]
    }
];

GetDatasetDirectQueryRefreshScheduleInGroup = (optional groupdId as text, optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/" & datasetId & "/directQueryRefreshSchedule")
    in
        result;
/*** End GetDatasetDirectQueryRefreshScheduleInGroup***/

/*** GetDatasetGatewayDatasourcesInGroup***/
// Deprecated
/*** End GetDatasetGatewayDatasourcesInGroup***/

/*** GetDatasetParametersInGroup***/
shared PBIRESTAPIGCC.GetDatasetParametersInGroup = Value.ReplaceType(
    GetDatasetParametersInGroup,
    GetDatasetParametersInGroupType
);

GetDatasetParametersInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyx1..."
            }
        ]
    )    
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetParametersInGroup",
    Documentation.LongDescription = "Returns a list of parameters for the specified dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetParametersInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyx1..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-parameters-in-group#mashupparameters"
        ]
    }
];

GetDatasetParametersInGroup = (optional groupdId as text, optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/" & datasetId & "/parameters")
    in
        result;
/*** End GetDatasetParametersInGroup***/

/*** GetDatasetRefreshExecutionDetailsInGroup***/
shared PBIRESTAPIGCC.GetDatasetRefreshExecutionDetailsInGroup = Value.ReplaceType(
    GetDatasetRefreshExecutionDetailsInGroup,
    GetDatasetRefreshExecutionDetailsInGroupType
);

GetDatasetRefreshExecutionDetailsInGroupType = type function (
    optional groupdId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyx1..."
            }
        ]
    ),
    optional refreshId as (
        type text meta [
            Documentation.FieldCaption = "Refresh ID",
            Documentation.FieldDescription = "The Refresh ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyx2..."
            }
        ]
    )        
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetRefreshExecutionDetailsInGroup",
    Documentation.LongDescription = "Returns execution details of an enhanced refresh operation for the specified dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetRefreshExecutionDetailsInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyx1..."",""xxx-xxxx-yyx2..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-refresh-execution-details-in-group#datasetrefreshdetail"
        ]
    }
];

GetDatasetRefreshExecutionDetailsInGroup = (optional groupdId as text, optional datasetId as text, optional refreshId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupdId & "/datasets/" & datasetId & "/refreshes/" & refreshId)
    in
        result;
/*** End GetDatasetRefreshExecutionDetailsInGroup***/

/*** GetDatasetRefreshHistoryInGroup***/
shared PBIRESTAPIGCC.GetDatasetRefreshHistoryInGroup = Value.ReplaceType(
    GetDatasetRefreshHistoryInGroup,
    GetDatasetRefreshHistoryInGroupType
);

GetDatasetRefreshHistoryInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetRefreshHistoryInGroup",
    Documentation.LongDescription = "Returns the refresh history for the specified dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetRefreshHistoryInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-refresh-history-in-group#refreshes"
        ]
    }
];

GetDatasetRefreshHistoryInGroup = (optional groupId as text , optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/datasets/" & datasetId & "/refreshes")
    in
        result;
/*** End GetDatasetRefreshHistoryInGroup***/

/*** GetDatasetRefreshScheduleInGroup***/
shared PBIRESTAPIGCC.GetDatasetRefreshScheduleInGroup = Value.ReplaceType(
    GetDatasetRefreshScheduleInGroup,
    GetDatasetRefreshScheduleInGroupType
);

GetDatasetRefreshScheduleInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetDatasetRefreshScheduleInGroup",
    Documentation.LongDescription = "Returns the refresh schedule for the specified dataset from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetDatasetRefreshScheduleInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/get-refresh-schedule-in-group#refreshschedule"
        ]
    }
];

GetDatasetRefreshScheduleInGroup = (optional groupId as text , optional datasetId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/datasets/" & datasetId & "/refreshSchedule")
    in
        result;
/*** End GetDatasetRefreshScheduleInGroup***/

/*** ExecuteQuery ***/
shared PBIRESTAPIGCC.ExecuteQuery = Value.ReplaceType(
    ExecuteQuery,
    ExecuteQueryType
);

ExecuteQueryType = type function (
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional daxQuery as (
        type text meta [
            Documentation.FieldCaption = "DAX Query",
            Documentation.FieldDescription = "A single DAX query which includes all keywords like EVALUATE or DEFINE.",
            Documentation.SampleValues = {
                "VALUES(Table[Column])"
            }
        ]
    ),
    optional impersonatedUPN as (
        type text meta [
            Documentation.FieldCaption = "The UPN of a user to be impersonated",
            Documentation.FieldDescription = "The UPN of a user to be impersonated. If the model is not RLS enabled, this will be ignored.",
            Documentation.SampleValues = {
                "example@somedomain.com"
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.ExecuteQuery",
    Documentation.LongDescription = "Executes Data Analysis Expressions (DAX) queries against the provided dataset. The dataset must reside in My workspace or another workspace.
    DAX query errors will result in:

    A response error, such as DAX query failure.
    A failure HTTP status code (400).
    A query that requests more than one table, or more than the allowed number of table rows, will result in:

    Limited data being returned.
    A response error, such as More than one result table in a query or More than {allowed number} rows in a query result.
    A successful HTTP status code (200).
    Columns that are fully qualified in the query will be returned with a fully qualified name, for example, MyTable[MyColumn]. Columns that are renamed or created in the query will be returned within square bracket, for example, [MyNewColumn].",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.ExecuteQuery(""xxx-xxxx-yyxa..."",""VALUES(Table[Column])"",""example@somedomain.com"")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/execute-queries-in-group#datasetexecutequeriesqueryresult"
        ]
    }
];

ExecuteQuery = (optional datasetId as text, optional daxQuery as text, optional impersonatedUPN as text) =>
    let
        //Check arguments
        doArgumentsExist = if(datasetId <> null and datasetId <> "") and (daxQuery <> null and daxQuery <> "") then true else false,
        //Build results
        result = if doArgumentsExist = false then 
                    // See back message that arguments are required
                    #table( type table [response = text],{{"Please provide datasetId or daxQuery arguments"}})
                 else
                    let
                        /* Escape query to fit in JSON*/
                        escapeTable = #table(1, {{daxQuery}}),
                        escapedJson = Table.ReplaceValue(escapeTable,"""","\""",Replacer.ReplaceText,{"Column1"}),
                        escapedJsonQuery = Table.FirstValue(escapedJson),
                        /* Escape impersonate argument appropriately */
                        impersonate = if (impersonatedUPN <> null and impersonatedUPN <> "") then ", ""impersonatedUserName"": """ & impersonatedUPN & """"
                                    else "",
                        /* Build parameters to send */
                        params = [RelativePath = "v1.0/myorg/datasets/" & datasetId & "/executeQueries",
                                    Headers = [ #"Content-Type" = "application/json"],
                                    Content = Text.ToBinary("{""queries"":[{""query"": """ & escapedJsonQuery & """}],""serializerSettings"":{""includeNulls"": false}" & impersonate & "}")
                                ],
                        postResult = PostJSON(params)
                    in
                        postResult
    in
        result;
/*** End ExecuteQuery***/

/*** ExecuteQueryInGroup ***/
shared PBIRESTAPIGCC.ExecuteQueryInGroup = Value.ReplaceType(
    ExecuteQueryInGroup,
    ExecuteQueryInGroupType
);

ExecuteQueryInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),    
    optional datasetId as (
        type text meta [
            Documentation.FieldCaption = "Dataset ID",
            Documentation.FieldDescription = "The Dataset ID",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional daxQuery as (
        type text meta [
            Documentation.FieldCaption = "DAX Query",
            Documentation.FieldDescription = "A single DAX query which includes all keywords like EVALUATE or DEFINE.",
            Documentation.SampleValues = {
                "VALUES(Table[Column])"
            }
        ]
    ),
    optional impersonatedUPN as (
        type text meta [
            Documentation.FieldCaption = "The UPN of a user to be impersonated",
            Documentation.FieldDescription = "The UPN of a user to be impersonated. If the model is not RLS enabled, this will be ignored.",
            Documentation.SampleValues = {
                "example@somedomain.com"
            }
        ]
    )
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.ExecuteQueryInGroup",
    Documentation.LongDescription = "Executes Data Analysis Expressions (DAX) queries against the provided dataset. The dataset must reside in My workspace or another workspace.
    DAX query errors will result in:

    A response error, such as DAX query failure.
    A failure HTTP status code (400).
    A query that requests more than one table, or more than the allowed number of table rows, will result in:

    Limited data being returned.
    A response error, such as More than one result table in a query or More than {allowed number} rows in a query result.
    A successful HTTP status code (200).
    Columns that are fully qualified in the query will be returned with a fully qualified name, for example, MyTable[MyColumn]. Columns that are renamed or created in the query will be returned within square bracket, for example, [MyNewColumn].",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.ExecuteQuery(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."",""VALUES(Table[Column])"",""example@somedomain.com"")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/datasets/execute-queries-in-group#datasetexecutequeriesqueryresult"
        ]
    }
];

ExecuteQueryInGroup = (optional groupId as text, optional datasetId as text, optional daxQuery as text, optional impersonatedUPN as text) =>
    let
        //Check arguments
        doArgumentsExist = if(groupId <> null and groupId <> "") and (datasetId <> null and datasetId <> "") and (daxQuery <> null and daxQuery <> "") then true else false,
        //Build results
        result = if doArgumentsExist = false then 
                    // See back message that arguments are required
                    #table( type table [response = text],{{"Please provide groupId, datasetId and daxQuery arguments"}})
                 else
                    let
                        /* Escape query to fit in JSON*/
                        escapeTable = #table(1, {{daxQuery}}),
                        escapedJson = Table.ReplaceValue(escapeTable,"""","\""",Replacer.ReplaceText,{"Column1"}),
                        escapedJsonQuery = Table.FirstValue(escapedJson),
                        /* Escape impersonate argument appropriately */
                        impersonate = if (impersonatedUPN <> null and impersonatedUPN <> "") then ", ""impersonatedUserName"": """ & impersonatedUPN & """"
                                    else "",
                        /* Build parameters to send */
                        params = [RelativePath = "v1.0/myorg/groups" & groupId & "/datasets/" & datasetId & "/executeQueries",
                                    Headers = [ #"Content-Type" = "application/json"],
                                    Content = Text.ToBinary("{""queries"":[{""query"": """ & escapedJsonQuery & """}],""serializerSettings"":{""includeNulls"": false}" & impersonate & "}")
                                ],
                        postResult = PostJSON(params)
                    in
                        postResult
    in
        result;
/*** End ExecuteQueryInGroup***/


/*****************
    Reports
*****************/

/*** GetPaginatedReportDatasourcesInGroup ***/
/*** End GetPaginatedReportDatasourcesInGroup ***/

/*** GetReportExportToFileStatusInGroup ***/
/*** End GetReportExportToFileStatusInGroup ***/

/*** GetReportPageInGroup ***/
shared PBIRESTAPIGCC.GetReportPageInGroup = Value.ReplaceType(
    GetReportPageInGroup,
    GetReportPageInGroupType
);

GetReportPageInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional reportId as (
        type text meta [
            Documentation.FieldCaption = "Report ID",
            Documentation.FieldDescription = "The Report ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional pageName as (
        type text meta [
            Documentation.FieldCaption = "Page Name",
            Documentation.FieldDescription = "The page name.",
            Documentation.SampleValues = {
                "ReportSection"
            }
        ]
    )    
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetReportPageInGroup",
    Documentation.LongDescription = "Returns the specified page within the specified report from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetReportPageInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."",""ReportSection"")",
            result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/reports/get-page-in-group#page"
        ]
    }
];

GetReportPageInGroup = (optional groupId as text , optional reportId as text, optional pageName as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/reports/" & reportId & "/pages/" & pageName)
    in
        result;
/*** End GetReportPageInGroup***/

/*** GetReportPagesInGroup ***/
shared PBIRESTAPIGCC.GetReportPagesInGroup = Value.ReplaceType(
    GetReportPagesInGroup,
    GetReportPagesInGroupType
);

GetReportPagesInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional reportId as (
        type text meta [
            Documentation.FieldCaption = "Report ID",
            Documentation.FieldDescription = "The Report ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )   
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetReportPagesInGroup",
    Documentation.LongDescription = "Returns a list of pages within the specified report from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetReportPagesInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/reports/get-pages-in-group#pages"
        ]
    }
];

GetReportPagesInGroup = (optional groupId as text , optional reportId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/reports/" & reportId & "/pages")
    in
        result;
/*** End GetReportPagesInGroup***/

/*** GetReportInGroup ***/
shared PBIRESTAPIGCC.GetReportInGroup = Value.ReplaceType(
    GetReportInGroup,
    GetReportInGroupType
);

GetReportInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional reportId as (
        type text meta [
            Documentation.FieldCaption = "Report ID",
            Documentation.FieldDescription = "The Report ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )   
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetReportInGroup",
    Documentation.LongDescription = "Returns the specified report from the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetReportInGroup(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxa..."",""ReportSection"")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/reports/get-report-in-group#report"
        ]
    }
];

GetReportInGroup = (optional groupId as text , optional reportId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/reports/" & reportId)
    in
        result;
/*** End GetReportInGroup***/

/*** GetReportsInGroup ***/
shared PBIRESTAPIGCC.GetReportsInGroup = Value.ReplaceType(
    GetReportsInGroup,
    GetReportsInGroupType
);

GetReportsInGroupType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )  
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetReportsInGroup",
    Documentation.LongDescription = "Returns a list of reports from the specified workspace. Since paginated reports (RDL) don't have a dataset, the dataset ID value in the API response for paginated reports isn't displayed.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetReportsInGroup(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/reports/get-reports-in-group#reports"
        ]
    }
];

GetReportsInGroup = (optional groupId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/reports")
    in
        result;
/*** End GetReportsInGroup***/

/*****************
    GROUPS
*****************/

/*** GetGroupUsers ***/
shared PBIRESTAPIGCC.GetGroupUsers = Value.ReplaceType(
    GetGroupUsers,
    GetGroupUsersType
);

GetGroupUsersType = type function (
    optional groupId as (
        type text meta [
            Documentation.FieldCaption = "Group ID",
            Documentation.FieldDescription = "The workspace ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )  
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetGroupUsers",
    Documentation.LongDescription = "Returns a list of users that have access to the specified workspace.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetGroupUsers(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/groups/get-group-users#groupusers"
        ]
    }
];

GetGroupUsers = (optional groupId as text) =>
    let
        result = GetJSON("v1.0/myorg/groups/" & groupId & "/users")
    in
        result;

/*** GetGroups ***/
shared PBIRESTAPIGCC.GetGroups = Value.ReplaceType(
    GetGroups,
    GetGroupsType
);

GetGroupsType = type function (
    optional filter as (
        type text meta [
            Documentation.FieldCaption = "Filter",
            Documentation.FieldDescription = "Filters the results, based on a boolean condition.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional top as (
        type number meta [
            Documentation.FieldCaption = "Top",
            Documentation.FieldDescription = "Returns only the first n results.",
            Documentation.SampleValues = {
                "5"
            }
        ]
    ),
    optional skip as (
        type number meta [
            Documentation.FieldCaption = "Skip",
            Documentation.FieldDescription = "Skips the first n results.",
            Documentation.SampleValues = {
                "10"
            }
        ]
    )              
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetGroups",
    Documentation.LongDescription = "Returns a list of workspaces the user has access to.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetGroups(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/groups/get-groups#groups"
        ]
    }
];

GetGroups = (optional filter as text, optional top as number, optional skip as number) =>
    let
        //Build Query String
        filterQS = if(filter <> null and filter <> "") then "$filter=" & filter else "",
        topQS = if(top <> null) then "$top=" & Number.ToText(top) else "",
        skipQS = if(skip <> null) then "$skip=" & Number.ToText(skip) else "",
        // Figure out if we need to concatenate with ampersand
        queryString = if(filterQS <> "" and topQS <> "" and skipQS <> "") 
                        then "?" & filterQS & "&" & topQS & "&" & skipQS
                        // 110
                        else
                            if(filterQS <> "" and topQS <> "" and skipQS = "" )
                                then 
                                    "?" & filterQS & "&" & topQS
                                    // 101
                                    else 
                                        if(filterQS <> "" and topQS = "" and skipQS <> "")
                                            then "?" & filterQS & "&" & skipQS
                                                // 011
                                                else 
                                                    if(filterQS = "" and topQS <> "" and skipQS <> "")
                                                        then "?" & topQS & "&" & skipQS
                                                            //000
                                                            else 
                                                                if(filterQS = "" and topQS = "" and skipQS = "")
                                                                    then ""
                                                                    //100 or 010 or 001 so just concatenate with ampersand
                                                                    else "?" & filterQS & topQS & skipQS,

        // Now query with parameters
        result = GetJSON("v1.0/myorg/groups" & queryString)
    in
        result;
/*** End GetGroups ***/

/*****************
    Pipelines
*****************/

/*** GetPipeline***/
shared PBIRESTAPIGCC.GetPipeline = Value.ReplaceType(
    GetPipeline,
    GetPipelineType
);

GetPipelineType = type function (
    optional pipelineId as (
        type text meta [
            Documentation.FieldCaption = "Pipeline ID",
            Documentation.FieldDescription = "The deployment pipeline ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional expand as (
        type text meta [
            Documentation.FieldCaption = "Expand",
            Documentation.FieldDescription = "Accepts a comma-separate list of data types, which will be expanded inline in the response. Supports stages.",
            Documentation.SampleValues = {
                "stages"
            }
        ]
    )              
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipeline",
    Documentation.LongDescription = "Returns the specified deployment pipeline.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipeline(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipeline#pipeline"
        ]
    }
];

GetPipeline = (optional pipelineId as text, optional expand as text) =>
    let
        //Build Query String
        expandQS = if(expand <> null and expand <> "") then "$expand=" & expand else "",
        // Now query with parameters
        result = GetJSON("v1.0/myorg/pipelines/" & pipelineId & expandQS)
    in
        result;
/*** End GetPipeline ***/

/*** GetPipelineOperation***/
shared PBIRESTAPIGCC.GetPipelineOperation = Value.ReplaceType(
    GetPipelineOperation,
    GetPipelineOperationType
);

GetPipelineOperationType = type function (
    optional pipelineId as (
        type text meta [
            Documentation.FieldCaption = "Pipeline ID",
            Documentation.FieldDescription = "The deployment pipeline ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional operationId as (
        type number meta [
            Documentation.FieldCaption = "Operation ID",
            Documentation.FieldDescription = "The operation ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )              
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipelineOperation",
    Documentation.LongDescription = "Returns the details of the specified deploy operation performed on the specified deployment pipeline, including the deployment execution plan.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipelineOperation(""xxx-xxxx-yyxa..."",""xxx-xxxx-yyxb..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipeline-operation#pipelineoperation"
        ]
    }
];

GetPipelineOperation = (optional pipelineId as text, optional operationId as text) =>
    let
        // Now query with parameters
        result = GetJSON("v1.0/myorg/pipelines/" & pipelineId & "/operations/" & operationId)
    in
        result;
/*** End GetPipelineOperation ***/

/*** GetPipelineOperations ***/
shared PBIRESTAPIGCC.GetPipelineOperations = Value.ReplaceType(
    GetPipelineOperations,
    GetPipelineOperationsType
);

GetPipelineOperationsType = type function (
    optional pipelineId as (
        type text meta [
            Documentation.FieldCaption = "Pipeline ID",
            Documentation.FieldDescription = "The deployment pipeline ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )              
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipelineOperations",
    Documentation.LongDescription = "Returns a list of the up-to-20 most recent deploy operations performed on the specified deployment pipeline.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipelineOperations(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipeline-operations#pipelineoperations"
        ]
    }
];

GetPipelineOperations = (optional pipelineId as text) =>
    let
        // Now query with parameters
        result = GetJSON("v1.0/myorg/pipelines/" & pipelineId & "/operations")
    in
        result;        
/*** End GetPipelineOperations ***/

/*** GetPipelineStageArtifacts ***/
shared PBIRESTAPIGCC.GetPipelineStageArtifacts = Value.ReplaceType(
    GetPipelineStageArtifacts,
    GetPipelineStageArtifactsType
);

GetPipelineStageArtifactsType = type function (
    optional pipelineId as (
        type text meta [
            Documentation.FieldCaption = "Pipeline ID",
            Documentation.FieldDescription = "The deployment pipeline ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    ),
    optional stageOrder as (
        type number meta [
            Documentation.FieldCaption = "Stage Order",
            Documentation.FieldDescription = "The deployment pipeline stage order. Development (0), Test (1), Production (2).",
            Documentation.SampleValues = {
                "0"
            }
        ]
    )                   
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipelineStageArtifacts",
    Documentation.LongDescription = "Returns the supported items from the workspace assigned to the specified stage of the specified deployment pipeline.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipelineStageArtifacts(""xxx-xxxx-yyxa..."",""0"")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipeline-stage-artifacts#pipelinestageartifacts"
        ]
    }
];

GetPipelineStageArtifacts = (optional pipelineId as text, optional stageOrder as number) =>
    let
        // Check stage order is right number
        result = if stageOrder <> 0 and stageOrder <> 1 and stageOrder <> 2 then
            #table( type table [response = text],{{"Stage Order needs to be 0 (Development), 1 (Test), or 2 (Production)"}})
        else
            // Now query with parameters
            GetJSON("v1.0/myorg/pipelines/" & pipelineId & "/stages/" & Number.ToText(stageOrder) & "/artifacts")
    in
        result; 
/*** GetPipelineStageArtifacts ***/

/*** GetPipelineStages ***/
shared PBIRESTAPIGCC.GetPipelineStages = Value.ReplaceType(
    GetPipelineStages,
    GetPipelineStagesType
);

GetPipelineStagesType = type function (
    optional pipelineId as (
        type text meta [
            Documentation.FieldCaption = "Pipeline ID",
            Documentation.FieldDescription = "The deployment pipeline ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )                   
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipelineStages",
    Documentation.LongDescription = "Returns the stages of the specified deployment pipeline.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipelineStages(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipeline-stages#pipelinestages"
        ]
    }
];

GetPipelineStages = (optional pipelineId as text) =>
    let
        // Now query with parameters
        result = GetJSON("v1.0/myorg/pipelines/" & pipelineId & "/stages")
    in
        result; 
/*** End GetPipelineStages ***/

/*** GetPipelineUsers ***/
shared PBIRESTAPIGCC.GetPipelineUsers = Value.ReplaceType(
    GetPipelineUsers,
    GetPipelineUsersType
);

GetPipelineUsersType = type function (
    optional pipelineId as (
        type text meta [
            Documentation.FieldCaption = "Pipeline ID",
            Documentation.FieldDescription = "The deployment pipeline ID.",
            Documentation.SampleValues = {
                "xxx-xxxx-yyxa..."
            }
        ]
    )                   
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipelineUsers",
    Documentation.LongDescription = "Returns a list of users that have access to the specified deployment pipeline.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipelineUsers(""xxx-xxxx-yyxa..."")",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipeline-users#pipelineusers"
        ]
    }
];

GetPipelineUsers = (optional pipelineId as text) =>
    let
        // Now query with parameters
        result = GetJSON("v1.0/myorg/pipelines/" & pipelineId & "/users")
    in
        result;
/*** GetPipelineUsers ***/

/*** GetPipelines ***/
shared PBIRESTAPIGCC.GetPipelines = Value.ReplaceType(
    GetPipelines,
    GetPipelinesType
);

GetPipelinesType = type function (                   
) as table meta [
    Documentation.Name = "PBIRESTAPIGCC.GetPipelines",
    Documentation.LongDescription = "Returns a list of deployment pipelines that the user has access to.",
    Documentation.Examples = {
        [
            Code = "=PBIRESTAPIGCC.GetPipelines()",
            Result = "Defined as https://learn.microsoft.com/en-us/rest/api/power-bi/pipelines/get-pipelines#pipelines"
        ]
    }
];

GetPipelines = () =>
    let
        // Now query with parameters
        result = GetJSON("v1.0/myorg/pipelines")
    in
        result;
/*** End GetPipelines ***/

/*****************
    HELPER FUNCTIONS
*****************/
GetJSON = (optional relPath as text) =>
    let
        params = [Headers = [#"Content-Type" = "application/json"], RelativePath = relPath],
        //Get Pages
        //Hard-coded Base URL because Power BI Service won't recognize parameter despite numerous attempts
        webSource = Web.Contents(
            "https://api.powerbigov.us",
            params
        ),
        //Convert to Json
        result = Text.FromBinary(webSource)
    in
        result;

PostJSON = (optional params as record) =>
    let
        //Post
        //Hard-coded Base URL because Power BI Service won't recognize parameter despite numerous attempts
        webSource = Web.Contents(
            "https://api.powerbigov.us",
            params
        ),
        //Convert to Json
        result = Text.FromBinary(webSource)
    in
        result;

// Data Source Kind description
PBIRESTAPIGCC = [
    TestConnection = (dataSourcePath) =>  { "PBIRESTAPIGCC.Navigation"},
    Authentication = [
        Aad = [
            AuthorizationUri = "https://login.windows.net/common/oauth2/authorize",
            Resource = "https://analysis.usgovcloudapi.net/powerbi/api"
        ]
    ]
];

// Data Source UI publishing description
PBIRESTAPIGCC.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = {
        Extension.LoadString(
            "ButtonTitle"
        ),
        Extension.LoadString(
            "ButtonHelp"
        )
    },
    LearnMoreUrl = "https://github.com/kerski/powerquery-connector-pbi-rest-api-gcc/blob/main/README.md#functions-implemented",
    SourceImage = PBIRESTAPIGCC.Icons,
    SourceTypeImage = PBIRESTAPIGCC.Icons
];

PBIRESTAPIGCC.Icons = [
    Icon16 = {
        Extension.Contents(
            "PBIRESTAPIGCC16.png"
        ),
        Extension.Contents(
            "PBIRESTAPIGCC20.png"
        ),
        Extension.Contents(
            "PBIRESTAPIGCC24.png"
        ),
        Extension.Contents(
            "PBIRESTAPIGCC32.png"
        )
    },
    Icon32 = {
        Extension.Contents(
            "PBIRESTAPIGCC32.png"
        ),
        Extension.Contents(
            "PBIRESTAPIGCC40.png"
        ),
        Extension.Contents(
            "PBIRESTAPIGCC48.png"
        ),
        Extension.Contents(
            "PBIRESTAPIGCC64.png"
        )
    }
];

//To Navigation Table
Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(
            table
        ),
        newTableType = Type.AddTableKey(
            tableType,
            keyColumns,
            true
        ) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(
            table,
            newTableType
        )
    in
        navigationTable;

// Force Navigation Table
Table.ForceToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(
            table
        ),
        newTableType = Type.AddTableKey(
            tableType,
            keyColumns,
            true
        ) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(
            table,
            newTableType
        )
    in
        navigationTable;
