#!/usr/bin/perl6

grammar Annotated-Vol1-Text1-Parser-Fabula {
  rule TOP {
    ^ [
      <plain>
        ||
      <section>+ % [\s*]
      ] $
  }
  token plain {
    <- [\(\)] - :digit> +
  }
  token number {
    <digit> +
  }
  token section {
    <number> ")" \s* <plain>
  }
}

grammar Annotated-Vol1-Text1-Parser-Notation {
  rule TOP {
    ^ [ <break-plot> || <section> || <plain> ] $
  }
  token section {
    <number>
    "." \s* <plain>
  }
  token number {
    <:digit + [a .. z]> +
  }
  token plain {
    [
      <- :digit> <- [\.]>
        ||
      <digit> + <- [a .. z]>
    ]
    .*
  }
  token break-plot {
    [
      "Пелек" ["а" || "а́"] "т" .*
        ||
      "-" \s* <digit>+ \s* "-"
    ]
  }
}

grammar Annotated-Vol2-Text1-Parser-Fabula {
  rule TOP {
    ^ [
      <plain>
        ||
      <section>+ % [\s*]
      ] $
  }
  token plain {
    [
      <- [\(\)] - :digit> +
      ||
      \( <- [\)]>* \)
    ]
  }
  token number {
    <digit> +
  }
  token section {
    <number> ")" \s* <plain>
  }
}

grammar Annotated-Vol2-Text1-Parser-Notation {
  rule TOP {
    ^ [ <break-plot> || <section> || <plain> ] $
  }
  token section {
    <number>
    "." \s* <plain>
  }
  token number {
    <:digit + [a .. z]> +
  }
  token plain {
    [
      <- :digit> <- [\.]>
        ||
      <digit> + <- [a .. z]>
    ]
    .*
  }
  token break-plot {
    \s* <digit>+ \s*
  }
}