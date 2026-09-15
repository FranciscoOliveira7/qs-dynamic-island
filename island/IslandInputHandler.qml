import QtQuick

Item {
  id: root

  property bool hovered: false


  HoverHandler {
    id: hover

    onHoveredChanged: {
      root.handleHoverChanged(hovered)
    }
  }

  function handleHoverChanged(isHovered) {
    root.hovered = isHovered

    if (!isHovered) {
      IslandController.setDefault()
    }
    if (isHovered) {
      IslandController.setExpanded()
    }
  }
}
