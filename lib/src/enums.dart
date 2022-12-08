enum PagePos {
  before,
  after,
  current,
  farBefore,
  farAfter,
}

extension PositionHelper on PagePos {
  bool get isBefore => this == PagePos.before;
  bool get isAfter => this == PagePos.after;
  bool get isCurrent => this == PagePos.current;
  bool get isFarBefore => this == PagePos.farBefore;
  bool get isFarAfter => this == PagePos.farAfter;
  bool get isFar => this == PagePos.farAfter || this == PagePos.farBefore;
}
