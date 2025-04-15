function addImport(t, programPath) {
  // Check if the import already exists to avoid duplicates
  const existingImport = programPath.node.body.find(
    (node) =>
      node.type === "ImportDeclaration" &&
      node.source.value === "mobx-react-lite"
  );
  if (existingImport) return false;

  // Create import declaration
  const importDeclaration = t.importDeclaration(
    [t.importNamespaceSpecifier(t.identifier("MobxReactLite"))],
    t.stringLiteral("mobx-react-lite")
  );

  // Insert the import at the beginning of the file
  programPath.node.body.unshift(importDeclaration);
  return true;
}

export default function (babel) {
  const { types: t } = babel;
  let wasImportAdded = false;

  return {
    name: "observer-wrapper",
    visitor: {
      Program() {
        // Reset the flag at the beginning of each file
        wasImportAdded = false;
      },
      FunctionDeclaration(path) {
        // Check that it is a component
        const name = path.node.id.name;
        const isComponent = /^[A-Z]/.test(name);
        if (!isComponent) return;
        if (!wasImportAdded) {
          const programPath = path.findParent((path) => path.isProgram());
          wasImportAdded = addImport(t, programPath);
        }

        // Convert to function expression
        const functionExpression = t.functionExpression(
          null,
          path.node.params, // Parameters of the function
          path.node.body, // The function body
          path.node.generator, // If the function is a generator
          path.node.async // If the function is async
        );

        // Create observer call
        const observerCall = t.callExpression(
          t.memberExpression(
            t.identifier("MobxReactLite"),
            t.identifier("observer")
          ),
          [functionExpression]
        );

        // Replace original function declaration
        path.replaceWith(
          t.variableDeclaration("var", [
            t.variableDeclarator(t.identifier("Component1"), observerCall)
          ])
        );
      }
    }
  };
}