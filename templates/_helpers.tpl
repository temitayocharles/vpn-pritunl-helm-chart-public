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
