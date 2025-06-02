extends Node
class_name Level

const DOCK_SIZE : int = 3

signal score_changed(score : int)

var run_data : RunData = null : set = _set_run_data
var pay_table : PayTable = null : set = _set_pay_table
var grid_modifier : GridModifier = null : set = _set_grid_modifier
var deal_cost_modifier : DealCostModifier = null : set = _set_deal_cost_modifier
var objectives : Array[Objective] = []
var score : int = 0 : set = _set_score
var deal_cost : int = 0 : set = _set_deal_cost

var board : CardMap = null
var dock : CardMap = null
var card_mover : CardMover = null
var card_spawner : CardSpawner = null
var objective_handler : ObjectiveHandler = null
var ui : UI = null

func _ready() -> void:
	board = %Board
	dock = %Dock
	card_mover = %CardMover
	card_spawner = %CardSpawner
	objective_handler = %ObjectiveHandler
	ui = %UI
	
	card_mover.card_maps.append(board)
	card_mover.card_maps.append(dock)
	
	card_spawner.card_spawned.connect(_on_card_spawner_card_spawned)
	card_spawner.card_not_spawned.connect(_on_card_spawner_card_not_spawned)
	
	ui.button_deal_pressed.connect(_on_button_deal_pressed)
	ui.button_submit_pressed.connect(_on_button_submit_pressed)
	return

func add_objective(objective : Objective) -> void:
	objectives.append(objective)
	return

func _deal_cards(num_cards : int = DOCK_SIZE) -> void:
	# discard any cards remaining on the dock
	var tiles_with_card : Array[Vector2i] = dock.card_grid.get_all_occupied_tiles()
	for tile : Vector2i in tiles_with_card:
		var card : Card = dock.card_grid.cards[tile]
		var card_data : CardData = card.data
		run_data.deck.add_card_discard_pile(card_data)
		dock.card_grid.remove_card(tile)
		card.queue_free()
	# deal new cards to the dock
	for index_card : int in range(num_cards):
		var card : CardData = run_data.deck.deal()
		if(card == null):
			run_data.deck.shuffle()
			card = run_data.deck.deal()
		card_spawner.spawn_card(dock, card)
	return

func _evaluate_row(row : int) -> void:
	var hand_rank : Hand.Rank = Evaluator.hand_rank_row(board.card_grid, row)
	var hand_rank_name : String = Hand.RankName[hand_rank]
	var payout : int = pay_table.payouts[hand_rank]
	if(hand_rank == Hand.Rank.PAIR or hand_rank == Hand.Rank.THREE_OF_A_KIND or hand_rank == Hand.Rank.FOUR_OF_A_KIND):
		var card_rank_mode : int = Evaluator.card_rank_mode_row(board.card_grid, row)
		pass # TODO: handle objectives here
	if(hand_rank == Hand.Rank.FLUSH or hand_rank == Hand.Rank.STRAIGHT_FLUSH or hand_rank == Hand.Rank.FULL_HOUSE or hand_rank == Hand.Rank.FLUSH_FIVE):
		var card_suit_mode : int = Evaluator.card_suit_mode_row(board.card_grid, row)
		pass # TODO: handle objectives here
	ui.update_hand_rank(row, Globals.NOT_COL, hand_rank_name)
	score += payout
	return

func _evaluate_col(col : int) -> void:
	var hand_rank : Hand.Rank = Evaluator.hand_rank_col(board.card_grid, col)
	var hand_rank_name : String = Hand.RankName[hand_rank]
	var payout : int = pay_table.payouts[hand_rank]
	if(hand_rank == Hand.Rank.PAIR or hand_rank == Hand.Rank.THREE_OF_A_KIND or hand_rank == Hand.Rank.FOUR_OF_A_KIND):
		var card_rank_mode : int = Evaluator.card_rank_mode_col(board.card_grid, col)
		pass # TODO: handle objectives here
	if(hand_rank == Hand.Rank.FLUSH or hand_rank == Hand.Rank.STRAIGHT_FLUSH or hand_rank == Hand.Rank.FULL_HOUSE or hand_rank == Hand.Rank.FLUSH_FIVE):
		var card_suit_mode : int = Evaluator.card_suit_mode_col(board.card_grid, col)
		pass # TODO: handle objectives here
	ui.update_hand_rank(Globals.NOT_ROW, col, hand_rank_name)
	score += payout
	return

func _evaluate_board() -> void:
	for row : int in range(board.num_rows()):
		if(board.card_grid.row_contains_new_cards(row)):
			_evaluate_row(row)
	for col : int in range(board.num_cols()):
		if(board.card_grid.col_contains_new_cards(col)):
			_evaluate_col(col)
	# cards can only trigger row/col evaluation once, so lock them when this function is done
	board.card_grid.lock_cards()
	return

func _set_run_data(value : RunData) -> void:
	run_data = value
	run_data.money_changed.connect(_on_run_data_money_changed)
	run_data.deck.shuffle()
	return

func _set_pay_table(value : PayTable) -> void:
	pay_table = value
	return

func _set_grid_modifier(value : GridModifier) -> void:
	grid_modifier = value
	# load in cards from the grid modifier and spawn them on the card grid
	for index_row : int in range(Globals.GRID_NUM_ROWS):
		for index_col : int in range(Globals.GRID_NUM_COLS):
			var tile : Vector2i = Vector2i(index_row, index_col)
			var card_data : CardData = grid_modifier.cards[tile]
			if(card_data != null):
				card_spawner.spawn_card_at_tile(board, card_data, tile)
	# set the spawned cards as fixed
	for tile : Vector2i in board.card_grid.get_all_occupied_tiles():
		board.card_grid.cards[tile].data.is_fixed = true
	return

func _set_deal_cost_modifier(value : DealCostModifier) -> void:
	deal_cost_modifier = value
	deal_cost = deal_cost_modifier.initial_cost
	return

func _set_score(value : int) -> void:
	score = value
	ui.set_score(score)
	score_changed.emit(score)
	return

func _set_deal_cost(value : int) -> void:
	deal_cost = value
	ui.button_deal.set_cost(deal_cost)
	return

func _on_run_data_money_changed(money : int) -> void:
	ui.set_money(money)
	return

func _on_card_spawner_card_spawned(card : Card) -> void:
	card_mover.setup_card(card)
	return

func _on_card_spawner_card_not_spawned(card_data : CardData) -> void:
	run_data.deck.add_card_draw_pile(card_data)
	return

func _on_button_deal_pressed() -> void:
	if(run_data.money - deal_cost >= 0):
		_deal_cards(DOCK_SIZE)
		run_data.money -= deal_cost
		deal_cost += deal_cost_modifier.cost_increase
	else:
		ui.button_deal.flash()
	return

func _on_button_submit_pressed() -> void:
	_evaluate_board()
	deal_cost = deal_cost_modifier.initial_cost
	return
