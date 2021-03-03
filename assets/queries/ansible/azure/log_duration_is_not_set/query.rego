package Cx

import data.generic.ansible as ansLib

CxPolicy[result] {
	task := ansLib.tasks[id][t]
	pgConfig := task["azure.azcollection.azure_rm_postgresqlconfiguration"]

	is_string(pgConfig.name)
	is_string(pgConfig.value)

	lower(pgConfig.name) == "log_duration"
	upper(pgConfig.value) != "ON"

	result := {
		"documentId": id,
		"searchKey": sprintf("name={{%s}}.{{azure.azcollection.azure_rm_postgresqlconfiguration}}.value", [task.name]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": sprintf("name={{%s}}.{{azure.azcollection.azure_rm_postgresqlconfiguration}}.value should be 'ON' for 'log_duration'", [task.name]),
		"keyActualValue": sprintf("name={{%s}}.{{azure.azcollection.azure_rm_postgresqlconfiguration}}.value is 'OFF' for 'log_duration'", [task.name]),
	}
}
