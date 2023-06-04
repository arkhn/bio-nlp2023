help:  ## Show help
	@grep -E '^[.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Clean autogenerated files
	rm -rf dist
	find . -type f -name "*.DS_Store" -ls -delete
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
	find . | grep -E ".pytest_cache" | xargs rm -rf
	find . | grep -E ".ipynb_checkpoints" | xargs rm -rf
	rm -f .coverage

clean-logs: ## Clean logs
	rm -rf logs/**

format: ## Run pre-commit hooks
	pre-commit run -a

sync: ## Merge changes from main branch to your current branch
	git pull
	git pull origin main

test: ## Run not slow tests
	pytest -k "not slow"

test-full: ## Run all tests
	pytest

run_experiment_debug: ## Run experiments
	python weak_supervision/train.py -m trainer.accelerator=gpu experiment=layer2_blended_comparison hparams_search=grid debug=fdr n_jobs=5


# ⚗️ Experiments
# 🍔 layer 2 comparison
# 🔗 wandb link: https://wandb.ai/clinical-dream-team/weak-supervision-instructgpt-e3c/groups/layer_2_comparison
layer_2_comparison:
	python weak_supervision/train.py -m trainer.accelerator=gpu experiment=layer2_comparison hparams_search=grid n_jobs=4

# 🍔 layer 2 validation comparison
# 🔗 wandb link: https://wandb.ai/clinical-dream-team/weak-supervision-instructgpt-e3c/groups/layer_2_validation_comparison
layer_2_validation_comparison:
	python weak_supervision/train.py -m trainer.accelerator=gpu experiment=layer2_validation_comparison hparams_search=grid n_jobs=4

# 🍔 layer 2 blended comparison
# 🔗 wandb link: https://wandb.ai/clinical-dream-team/weak-supervision-instructgpt-e3c/groups/layer_2_blended_comparison
layer_2_blended_comparison:
	python weak_supervision/train.py -m trainer.accelerator=gpu experiment=layer2_blended_comparison hparams_search=grid n_jobs=4

# 🍔 layer 2 blended methods
# 🔗 wandb link: https://wandb.ai/clinical-dream-team/weak-supervision-instructgpt-e3c/groups/layer_2_blended_methods
layer_2_blended_methods:
	python weak_supervision/train.py -m trainer.accelerator=gpu experiment=layer2_blended_methods hparams_search=grid n_jobs=4

# 🍔 layer 2 xlm
# 🔗 wandb link: https://wandb.ai/clinical-dream-team/weak-supervision-instructgpt-e3c/groups/layer_2_xlm
layer_2_xlm:
	python weak_supervision/train.py -m trainer.accelerator=gpu experiment=layer2_xlm n_jobs=4
