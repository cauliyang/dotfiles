def latex_template(name, title):
    return "\n".join(
        (
            r"\begin{figure}[ht]",
            r"    This is a custom LaTeX template!",
            r"    \centering",
            rf"    \incfig[1]{{{name}}}",
            rf"    \caption{{{title}}}",
            rf"    \label{{fig:{name}}}",
            r"\end{figure}",
        )
    )
