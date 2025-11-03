{{/*
Expand the name of the chart.
*/}}
{{- define "app-helm-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app-helm-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app-helm-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app-helm-chart.labels" -}}
helm.sh/chart: {{ include "app-helm-chart.chart" . }}
{{ include "app-helm-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app-helm-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app-helm-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "app-helm-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "app-helm-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the ingress resource.
*/}}
{{- define "app-helm-chart.ingressName" -}}
{{- if .Values.ingress.name -}}
{{- .Values.ingress.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" (include "app-helm-chart.fullname" .) "ingress" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{/*
Create the name of the service resource.
*/}}
{{- define "app-helm-chart.serviceName" -}}
{{- if .Values.service.name -}}
{{- .Values.service.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" (include "app-helm-chart.fullname" .) "service" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}