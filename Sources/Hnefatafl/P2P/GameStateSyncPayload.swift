import LINKER

struct GameStateSyncPayload: Equatable, Sendable {
    let cells: [String?]
    let currentPlayer: String
    let moveHistory: [[Int]]
    let variant: String

    func toJson() -> Json {
        let cellsJson = Json.array(cells.map { cell in
            cell.map { Json.string($0) } ?? Json.null
        })
        let movesJson = Json.array(moveHistory.map { coords in
            Json.array(coords.map { Json.int($0) })
        })
        return .object([
            "cells": cellsJson,
            "currentPlayer": .string(currentPlayer),
            "moveHistory": movesJson,
            "variant": .string(variant)
        ])
    }

    static func fromJson(_ json: Json) -> GameStateSyncPayload? {
        guard let cellsArr = json["cells"]?.arrayValue,
              let currentPlayer = json["currentPlayer"]?.stringValue,
              let movesArr = json["moveHistory"]?.arrayValue,
              let variant = json["variant"]?.stringValue else {
            return nil
        }
        let cells: [String?] = cellsArr.map { $0.stringValue }
        let moveHistory: [[Int]] = movesArr.compactMap { move in
            move.arrayValue?.compactMap { $0.intValue }
        }
        return GameStateSyncPayload(
            cells: cells,
            currentPlayer: currentPlayer,
            moveHistory: moveHistory,
            variant: variant
        )
    }
}
