extends Node
class_name Evaluator

static func hand_rank_row(card_grid : CardGrid, row : int) -> Hand.Rank:
	var row_cards : Array[CardData] = card_grid.get_row_of_cards(row)
	var hand_rank : Hand.Rank = Hand.rank(row_cards)
	return hand_rank

static func hand_rank_col(card_grid : CardGrid, col : int) -> Hand.Rank:
	var col_cards : Array[CardData] = card_grid.get_column_of_cards(col)
	var hand_rank : Hand.Rank = Hand.rank(col_cards)
	return hand_rank

static func payout_row(card_grid : CardGrid, pay_table : PayTable, row : int) -> int:
	var row_cards : Array[CardData] = card_grid.get_row_of_cards(row)
	var hand_rank : Hand.Rank = Hand.rank(row_cards)
	var payout : int = pay_table.payouts[hand_rank]
	return payout

static func payout_col(card_grid : CardGrid, pay_table : PayTable, col : int) -> int:
	var col_cards : Array[CardData] = card_grid.get_col_of_cards(col)
	var hand_rank : Hand.Rank = Hand.rank(col_cards)
	var payout : int = pay_table.payouts[hand_rank]
	return payout

static func card_rank_mode_row(card_grid : CardGrid, row : int) -> int:
	var row_cards : Array[CardData] = card_grid.get_row_of_cards(row)
	var card_rank_mode : int = Hand.card_rank_mode(row_cards)
	return card_rank_mode

static func card_rank_mode_col(card_grid : CardGrid, col : int) -> int:
	var col_cards : Array[CardData] = card_grid.get_col_of_cards(col)
	var card_rank_mode : int = Hand.card_rank_mode(col_cards)
	return card_rank_mode

static func card_suit_mode_row(card_grid : CardGrid, row : int) -> int:
	var row_cards : Array[CardData] = card_grid.get_row_of_cards(row)
	var card_suit_mode : int = Hand.card_suit_mode(row_cards)
	return card_suit_mode

static func card_suit_mode_col(card_grid : CardGrid, col : int) -> int:
	var col_cards : Array[CardData] = card_grid.get_col_of_cards(col)
	var card_suit_mode : int = Hand.card_suit_mode(col_cards)
	return card_suit_mode
