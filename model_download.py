import streamlit as st
from PIL import Image
from transformers import AutoModelForCausalLM, AutoTokenizer
import re
import time
import timm
import torchvision

@st.cache_resource
def load_model():
    # Load the model and tokenizer
    model_id = "vikhyatk/moondream2"
    revision = "2024-03-05"
    model = AutoModelForCausalLM.from_pretrained(
        model_id, trust_remote_code=True, revision=revision
    )
    tokenizer = AutoTokenizer.from_pretrained(model_id, revision=revision)
    return model, tokenizer

# Load the model and tokenizer
model, tokenizer = load_model()