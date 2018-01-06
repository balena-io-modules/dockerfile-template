declare module 'dockerfile-template' {

	export interface TemplateVariables {
		[variable: string]: string;
	}

	export function process(dockerfileTemplate: string, variables: TemplateVariables): string;
}
