{{/*
Expand the name of the chart.
*/}}
{{- define "tg-global-messaging-platform-rabbitmq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}