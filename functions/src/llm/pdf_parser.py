import io
import logging
from typing import Any

import pypdf

logger = logging.getLogger(__name__)

class PdfParser:
    def __init__(self):
        pass

    def parse_tups(self, data: bytes) -> list[dict[str, Any]]:
        r'''
        pdfファイルを読み込む
        [参照]
        ...\botob\functions\venv\Lib\site-packages\llama_index\readers\file\docs_reader.py
        '''
        logger.debug('PdfParser.parse_tups: called')

        stream = io.BytesIO(data)
        pdf = pypdf.PdfReader(stream)
        if pdf.is_encrypted:
            logger.info('PdfParser.parse_tups: pdf is encrypted and cannot be read')
            return []        
        num_pages = len(pdf.pages)
        # Iterate over every page
        pdf_tups: list[dict[str, Any]] = []
        for page in range(num_pages):
            # Extract the text from the page
            page_text = pdf.pages[page].extract_text()
            d = dict(text=page_text, page=page+1)
            pdf_tups.append(d)

        logger.debug('PdfParser.parse_tups: finished')
        logger.debug(f'pdf_tups: {pdf_tups}')
        return pdf_tups
    