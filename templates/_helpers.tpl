{{/* Generate a name using the chart name and release name */}}
{{- define "vpn-pritunl.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/* Short name */}}
{{- define "vpn-pritunl.name" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}

{{/* Chart label */}}
{{- define "vpn-pritunl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- end }}

{{/* Common metadata labels for Pritunl components */}}
{{- define "vpn-pritunl.labels" -}}
app.kubernetes.io/name: {{ include "vpn-pritunl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Labels used for selector matching */}}
{{- define "vpn-pritunl.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vpn-pritunl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
